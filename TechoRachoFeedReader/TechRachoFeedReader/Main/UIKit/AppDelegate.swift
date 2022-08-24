/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let usecase = ArticleUsecase(remoteRepository: RemoteArticleRepositoryImpl(),
                                     cacheRepository: ArticleCacheRepositoryImpl())
        let viewModel = ArticleListViewModel(usecase: usecase)
        let vc = ArticleListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
