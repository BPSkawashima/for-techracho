/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine
import Foundation

private let kArchiveKey = "articles"

class ArticleCacheRepositoryImpl: ArticleCacheRepository {
    func fetch() -> AnyPublisher<[Article], Error> {
        return Future<[Article], Error> { promise in
            do {
                guard let data = UserDefaults.standard.data(forKey: kArchiveKey) else {
                    promise(.success([]))
                    return
                }

                let articles =
                    try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Article] ?? []
                promise(.success(articles))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    func save(articles: [Article]) {
        do {
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: articles,
                                                                requiringSecureCoding: false)
            UserDefaults.standard.set(archivedData, forKey: kArchiveKey)
        } catch {
            // 何もしない
            return
        }
    }
}
