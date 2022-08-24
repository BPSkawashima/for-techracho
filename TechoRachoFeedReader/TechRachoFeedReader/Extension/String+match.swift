/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Foundation

// See: https://zenn.dev/kyome/articles/1a55547614dd495a869d

extension String {
    func match(_ pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let matched =
              regex.firstMatch(in: self, range: NSRange(location: 0, length: count))
        else { return [] }
        return (0 ..< matched.numberOfRanges).map {
            NSString(string: self).substring(with: matched.range(at: $0))
        }
    }
}
