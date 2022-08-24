/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import SwiftUI
import UIKit

struct ArticleListView: View {
    @ObservedObject var viewModel: ArticleListViewModel

    init(viewModel: ArticleListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView {
                    let padding = 12.0
                    ForEach(viewModel.dataSource) { article in
                        NavigationLink {
                            ArticleDetail(title: article.title ?? "",
                                          url: article.links.first!)
                        } label: {
                            ArticleRow(viewModel: ArticleRowViewModel(article: article),
                                       width: geometry.size.width - padding)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                    }
                    .padding(padding)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(.columns)
                .navigationBarTitle("TechRacho")
                .navigationBarItems(
                    leading: Button("更新") {
                        viewModel.reload()
                    }
                )
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        let usecase = ArticleUsecase(remoteRepository: RemoteArticleRepositoryImpl(),
                                     cacheRepository: ArticleCacheRepositoryImpl())
        ArticleListView(viewModel: ArticleListViewModel(usecase: usecase))
    }
}
