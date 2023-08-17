/*
 * Copyright (c) 2023 BPS Co., Ltd.
 * All rights reserved.
 */

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {

    @State var enlarge = false

    var body: some View {
        let usecase = ArticleUsecase(remoteRepository: ArticleRepositoryStub(),
                                     cacheRepository: ArticleCacheRepositoryImpl())
        ZStack(alignment: .bottom) {
            ArticleListView(viewModel: ArticleListViewModel(usecase: usecase))

            RealityView { content in
                let model = ModelEntity(
                             mesh: .generateSphere(radius: 0.1),
                             materials: [SimpleMaterial(color: .white, isMetallic: true)])
                content.add(model)
            } update: { content in
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1.4 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
                enlarge.toggle()
            })

            Toggle("Enlarge RealityView Content", isOn: $enlarge)
                .toggleStyle(.button)
        }
    }
}

#Preview {
    ContentView()
}
