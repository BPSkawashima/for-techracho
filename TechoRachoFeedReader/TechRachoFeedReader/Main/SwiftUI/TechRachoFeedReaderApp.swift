/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import FeedKit
import SwiftUI

@main
struct TechRachoFeedReaderApp: App {
    var body: some Scene {
        let usecase = ArticleUsecase(remoteRepository: RemoteArticleRepositoryImpl(),
                                     cacheRepository: ArticleCacheRepositoryImpl())
        WindowGroup {
            ArticleListView(viewModel: ArticleListViewModel(usecase: usecase))
        }
    }
}
