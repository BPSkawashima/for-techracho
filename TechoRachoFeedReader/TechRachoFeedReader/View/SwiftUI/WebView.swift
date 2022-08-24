/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    private let webView = WKWebView()
    let url: URL

    func makeUIView(context _: Context) -> WKWebView {
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}
}
