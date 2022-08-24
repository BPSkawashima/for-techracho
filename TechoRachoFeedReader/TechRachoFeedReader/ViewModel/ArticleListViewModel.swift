/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine
import SwiftUI

class ArticleListViewModel: ObservableObject, Identifiable {
    @Published var dataSource: [Article] = []

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
                receiveValue: { [weak self] value in
                    self?.dataSource = value
                }
            )
            .store(in: &disposables)
    }
}
