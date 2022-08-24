/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine
import Foundation
import UIKit

class ArticleRowViewModel: ObservableObject, Identifiable {
    @Published var image: UIImage? = nil
    let article: Article

    private var disposables = Set<AnyCancellable>()

    init(article: Article) {
        self.article = article
        setup()
    }

    private func setup() {
        loadImage()
    }

    private func loadImage() {
        guard let url = article.thumbnailImageURL else {
            return
        }

        ImageLoader.load(url: url)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] image in
                      self?.image = image
                  })
            .store(in: &disposables)
    }
}
