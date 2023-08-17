/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine
import Foundation

class ArticleRepositoryStub: RemoteArticleRepository {
    func fetch() -> AnyPublisher<[Article], Error> {
        return Future<[Article], Error> { promise in
            DispatchQueue.global().async {
                let list = [
                    Article(
                        title: "記事1",
                        summary: "サマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリー",
                        authors: ["田中 太郎", "あああ"],
                        links: [URL(string: "https://google.com")!],
                        thumbnailImageURL: URL(string: "https://techracho.bpsinc.jp/wp-content/uploads/2023/08/Unity_CSharp4_eyecatch-min-768x461.png")!,
                        categories: ["AAA", "BBB", "CCC"],
                        updated: Date()
                    ),
                    Article(
                        title: "記事2",
                        summary: "サマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリー",
                        authors: ["田中 太郎", "あああ"],
                        links: [URL(string: "https://google.com")!],
                        thumbnailImageURL: URL(string: "https://techracho.bpsinc.jp/wp-content/uploads/2023/08/folding_laundries_eyecatch3-min-768x461.png")!,
                        categories: ["AAA", "BBB", "CCC"],
                        updated: Date()
                    ),
                    Article(
                        title: "記事3",
                        summary: "サマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリーサマリー",
                        authors: ["田中 太郎", "あああ"],
                        links: [URL(string: "https://google.com")!],
                        thumbnailImageURL: URL(string:"https://techracho.bpsinc.jp/wp-content/uploads/2023/08/marketing_eyecatch2-min-768x461.png")!,
                        categories: ["AAA", "BBB", "CCC"],
                        updated: Date()
                    ),
                ]
                promise(.success(list))
            }
        }
        .eraseToAnyPublisher()
    }
}
