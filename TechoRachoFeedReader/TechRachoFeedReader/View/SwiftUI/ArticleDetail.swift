/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import SwiftUI
import WebKit

struct ArticleDetail: View {
    let title: String
    let url: URL

    var body: some View {
        VStack {
            WebView(url: url)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(title)
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(title: "title", url: URL(string: "https://google.com")!)
    }
}
