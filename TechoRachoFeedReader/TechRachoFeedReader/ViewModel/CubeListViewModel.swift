/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine
import SwiftUI
import RealityKit

struct CubeEntry: Identifiable {
    var id: Article {
        self.article
    }
    let article: Article
    let texture: TextureResource
}

class CubeListViewModel: ObservableObject, Identifiable {
    @Published var dataSource: [CubeEntry] = []

    private let usecase: ArticleUsecase
    private var disposables = Set<AnyCancellable>()

    init(usecase: ArticleUsecase) {
        self.usecase = usecase
        setup()
    }

    func reload() {
        updateState(publisher: usecase.update())
    }

    private func setup() {
        updateState(publisher: usecase.getCache())
    }

    private func updateState(publisher: AnyPublisher<[Article], Error>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { articles in
                    
                    var textures :[CubeEntry] = []
                    for article in articles {
                        do {
                            let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(article.title ?? "a")
                            let data = try! Data(contentsOf: article.thumbnailImageURL!)
                            try! data.write(to: fileURL)

                            let texture = try TextureResource.load(contentsOf: fileURL)
                            textures.append(CubeEntry(article: article, texture: texture))
                        } catch {
                            // 何もしない
                            print(error.localizedDescription)
                        }
                    }
                    self.dataSource = textures;
                }
            )
            .store(in: &disposables)
    }
}
