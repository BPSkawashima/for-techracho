/*
 * Copyright (c) 2023 BPS Co., Ltd.
 * All rights reserved.
 */

import SwiftUI

@main
struct TechRachoFeedReaderForVisionApp: App {
    var body: some Scene {
        let usecase = ArticleUsecase(remoteRepository: ArticleRepositoryStub(),
                                     cacheRepository: ArticleCacheRepositoryImpl())

        WindowGroup {
            CubeListView(viewModel: CubeListViewModel(usecase: usecase))
        }.windowStyle(.volumetric)
    }
}
