/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine

class ArticleUsecase {
    private let remoteRepository: RemoteArticleRepository
    private let cacheRepository: ArticleCacheRepository

    init(
        remoteRepository: RemoteArticleRepository,
        cacheRepository: ArticleCacheRepository
    ) {
        self.remoteRepository = remoteRepository
        self.cacheRepository = cacheRepository
    }

    func update() -> AnyPublisher<[Article], Error> {
        return remoteRepository
            .fetch()
            .handleEvents(receiveOutput: { output in
                self.cacheRepository.save(articles: output)
            })
            .eraseToAnyPublisher()
    }

    func getCache() -> AnyPublisher<[Article], Error> {
        return cacheRepository.fetch()
    }
}
