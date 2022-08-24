/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import UIKit
import WebKit

class ArticleDetailViewController: UIViewController {
    let url: URL

    private let webView = WKWebView()

    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)

        webView.load(URLRequest(url: url))
        webView.translatesAutoresizingMaskIntoConstraints = false

        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}
