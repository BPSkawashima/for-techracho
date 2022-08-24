/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Foundation

extension Date {
    static func stringFromDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        return formatter.string(from: date)
    }

    func yyyyMMdd_jp() -> String {
        return Date.stringFromDate(date: self,
                                   format: "yyyy年MM月dd日")
    }
}
