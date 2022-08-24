/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine
import UIKit

class ArticleListViewController: UIViewController {
    let viewModel: ArticleListViewModel

    private let tableView = UITableView()
    private var dataSource: [Article] = []
    private var disposables = Set<AnyCancellable>()

    init(viewModel: ArticleListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemBackground

        setupTableView()
        layoutNavigation()
        layoutTableView()
        bind()
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleRowCell.self, forCellReuseIdentifier: "ArticleRowCell")
        tableView.separatorColor = .clear
    }

    func layoutNavigation() {
        title = "TechRacho"
        let updateButtonItem =
            UIBarButtonItem(title: "更新",
                            style: .plain,
                            target: self,
                            action: #selector(onUpdate))
        navigationItem.leftBarButtonItems = [updateButtonItem]
    }

    func layoutTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    func bind() {
        viewModel
            .$dataSource
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] value in
                    self?.dataSource = value
                    self?.tableView.reloadData()
                }
            )
            .store(in: &disposables)
    }

    @objc
    func onUpdate() {
        viewModel.reload()
    }
}

extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleRowCell") as? ArticleRowCell else {
            return UITableViewCell()
        }
        let article = dataSource[indexPath.row]
        cell.update(viewModel: ArticleRowViewModel(article: article))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = dataSource[indexPath.row]
        let vc = ArticleDetailViewController(url: article.links.first!)
        vc.title = article.title
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ArticleListViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return dataSource.count
    }
}
