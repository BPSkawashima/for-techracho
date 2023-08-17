/*
 * Copyright (c) 2023 BPS Co., Ltd.
 * All rights reserved.
 */

import SwiftUI
import RealityKit

struct CubeListView: View {

    @ObservedObject var viewModel: CubeListViewModel

    init(viewModel: CubeListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Button("更新") {
                viewModel.reload()
            }
            .padding(50)

            HStack {
                ForEach(viewModel.dataSource) { ball in
                    VStack {
                        Text(ball.article.title ?? "")
                            .foregroundColor(Color.white)
                            .font(.title)

                        RealityView { content in
                            var material = SimpleMaterial()
                            material.baseColor = MaterialColorParameter.texture(ball.texture)
                            let entity = ModelEntity(mesh: .generateBox(size: 0.2), materials: [material])
                            content.add(entity)
                        }
                        .frame(width: 300, height: 300)
                    }
                }
            }
        }
    }
}

#Preview {
    let usecase = ArticleUsecase(remoteRepository: ArticleRepositoryStub(),
                                 cacheRepository: ArticleCacheRepositoryImpl())
    return ArticleListView(viewModel: ArticleListViewModel(usecase: usecase))
}
