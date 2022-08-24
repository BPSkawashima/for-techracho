/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine
import FeedKit
import Foundation

private let kFeedURL = "https://techracho.bpsinc.jp/feed/atom"

class RemoteArticleRepositoryImpl: RemoteArticleRepository {
    func fetch() -> AnyPublisher<[Article], Error> {
        return Future<[Article], Error> { [weak self] promise in
            DispatchQueue.global().async {
                guard let weakSelf = self, let url = URL(string: kFeedURL) else {
                    promise(.failure(RemoteArticleError.unexpected))
                    return
                }

                let parser = FeedParser(URL: url)
                let result = parser.parse()

                switch result {
                case let .success(feed):
                    promise(.success(weakSelf.convert(feed)))
                    return
                case let .failure(error):
                    promise(.failure(error))
                    return
                }
            }
        }
        .eraseToAnyPublisher()
    }

    private func convert(_ feed: Feed) -> [Article] {
        switch feed {
        case let .atom(atom):
            guard let entries = atom.entries else {
                return []
            }
            return entries.map { entry in
                let title = entry.title
                let originalSummary = entry.summary?.value
                let summary = originalSummary?.replacingOccurrences(of: "<.+?>",
                                                                    with: "",
                                                                    options: .regularExpression,
                                                                    range: nil)

                let authors = entry.authors?.compactMap { $0.name } ?? []
                let links = entry
                    .links?
                    .compactMap { $0.attributes?.href }
                    .compactMap { URL(string: $0) } ?? []

                // Summaryの1個目のimageタグのsrcをサムネイル画像とする
                let src
                    = originalSummary?.match(#"<img.*?src\s*=\s*[\"|\'](.*?)[\"|\'].*?>"#)[1]
                var thumbnailImageURL: URL?
                if let urlString = src {
                    thumbnailImageURL = URL(string: urlString)
                }
                let categories = entry.categories?.compactMap {
                    $0.attributes?.term
                } ?? []

                // publish と published の未来の方を使う
                let publishDate = entry.updated ?? Date(timeIntervalSince1970: 0)
                let updateDate = entry.published ?? Date(timeIntervalSince1970: 0)
                let updated = publishDate.compare(updateDate) == ComparisonResult.orderedDescending
                    ? publishDate : updateDate

                return Article(title: title,
                               summary: summary,
                               authors: authors,
                               links: links,
                               thumbnailImageURL: thumbnailImageURL,
                               categories: categories,
                               updated: updated)
            }
        default:
            // Future
            return []
        }
    }
}
