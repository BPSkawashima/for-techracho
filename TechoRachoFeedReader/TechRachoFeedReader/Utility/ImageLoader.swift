/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine
import Foundation
import UIKit

enum ImageLoaderError: Error {
    case unexpected
}

enum ImageLoader {
    static func load(url: URL) -> AnyPublisher<UIImage, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                guard let img = UIImage(data: $0.data) else {
                    throw ImageLoaderError.unexpected
                }
                return img
            }
            .eraseToAnyPublisher()
    }
}
