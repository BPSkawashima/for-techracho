/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine

protocol ArticleCacheRepository {
    func fetch() -> AnyPublisher<[Article], Error>
    func save(articles: [Article])
}
