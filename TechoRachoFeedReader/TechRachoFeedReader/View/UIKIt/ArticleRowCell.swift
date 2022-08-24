/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import Combine
import UIKit

class ArticleRowCell: UITableViewCell {
    var viewModel: ArticleRowViewModel?
    private var disposables = Set<AnyCancellable>()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let autherLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 3
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let imageBaseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let tabCollectionView: UICollectionView = {
        let flowLayout = LeftAlignedCollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    func update(viewModel: ArticleRowViewModel) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.article.title ?? ""
        let autherText = viewModel.article.authors.isEmpty ? "" :
            viewModel.article.authors.count > 1 ?
            viewModel.article.authors.first! + " 他" :
            viewModel.article.authors.first

        autherLabel.text = autherText
        dateLabel.text = viewModel.article.updated?.yyyyMMdd_jp() ?? ""
        summaryLabel.text = viewModel.article.summary ?? ""
        layoutBaseImage(image: nil)

        bind()
    }

    private func bind() {
        viewModel?
            .$image
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] image in
                    self?.layoutBaseImage(image: image)
                }
            )
            .store(in: &disposables)
    }

    private func layoutBaseImage(image: UIImage?) {
        let subviews = imageBaseView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }

        if let img = image {
            let imageView = UIImageView(image: img)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageBaseView.addSubview(imageView)

            imageView.topAnchor.constraint(equalTo: imageBaseView.topAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: imageBaseView.bottomAnchor).isActive = true
            imageView.leftAnchor.constraint(equalTo: imageBaseView.leftAnchor).isActive = true
            imageView.rightAnchor.constraint(equalTo: imageBaseView.rightAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 2 / 3)
                .isActive = true
        } else {
            let view = UIView()
            view.backgroundColor = .gray
            view.translatesAutoresizingMaskIntoConstraints = false
            imageBaseView.addSubview(view)

            view.topAnchor.constraint(equalTo: imageBaseView.topAnchor)
                .isActive = true
            view.bottomAnchor.constraint(equalTo: imageBaseView.bottomAnchor)
                .isActive = true
            view.leftAnchor.constraint(equalTo: imageBaseView.leftAnchor)
                .isActive = true
            view.rightAnchor.constraint(equalTo: imageBaseView.rightAnchor)
                .isActive = true
            view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2 / 3)
                .isActive = true
        }
    }

    private func setupViews() {
        tabCollectionView.delegate = self
        tabCollectionView.dataSource = self

        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(autherLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(imageBaseView)
        containerView.addSubview(summaryLabel)
        containerView.addSubview(tabCollectionView)

        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0)
            .isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0)
            .isActive = true
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12.0)
            .isActive = true
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12.0)
            .isActive = true

        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8.0)
            .isActive = true
        titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8.0)
            .isActive = true
        titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8.0)
            .isActive = true

        autherLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0)
            .isActive = true
        autherLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8.0)
            .isActive = true

        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0)
            .isActive = true
        dateLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8.0)
            .isActive = true

        imageBaseView.topAnchor.constraint(equalTo: autherLabel.bottomAnchor, constant: 8.0)
            .isActive = true
        imageBaseView.leftAnchor.constraint(equalTo: containerView.leftAnchor)
            .isActive = true
        imageBaseView.rightAnchor.constraint(equalTo: containerView.rightAnchor)
            .isActive = true

        summaryLabel.topAnchor.constraint(equalTo: imageBaseView.bottomAnchor, constant: 8.0)
            .isActive = true
        summaryLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8.0)
            .isActive = true
        summaryLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8.0)
            .isActive = true

        tabCollectionView.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor, constant: 4.0)
            .isActive = true
        tabCollectionView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8.0)
            .isActive = true
        tabCollectionView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8.0)
            .isActive = true
        tabCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8.0)
            .isActive = true

        // reloadData後でないとcollectionViewの高さが確定しないため、一時的なサイズを設定（二行分）
        let tempHeightConst = tabCollectionView.heightAnchor.constraint(equalToConstant: 50)
        tempHeightConst.isActive = true

        // See: https://qiita.com/ponkichi4/items/d5d46556773a6bc98f9c
        UIView.animate(withDuration: 0.0, animations: {
            self.tabCollectionView.reloadData()
        }) { _ in
            tempHeightConst.isActive = false
            self.tabCollectionView.heightAnchor.constraint(equalToConstant: self.tabCollectionView.collectionViewLayout.collectionViewContentSize.height)
                .isActive = true
        }
    }
}

extension ArticleRowCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        cell.textLabel.text = viewModel?.article.categories[indexPath.row] ?? ""
        return cell
    }
}

extension ArticleRowCell: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel?.article.categories.count ?? 0
    }
}

extension ArticleRowCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = viewModel?.article.categories[indexPath.row] ?? ""
        label.sizeToFit()
        let size = label.frame.size
        return CGSize(width: size.width + 8, height: 24)
    }
}

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.representedElementCategory == .cell {
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
        }
        return attributes
    }
}
