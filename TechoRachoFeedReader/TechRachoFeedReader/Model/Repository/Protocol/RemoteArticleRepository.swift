/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine

enum RemoteArticleError: Error {
    case unexpected
}

protocol RemoteArticleRepository {
    func fetch() -> AnyPublisher<[Article], Error>
}
