/*
 * Copyright (c) 2022 BPS Co., Ltd.
 * All rights reserved.
 */

import UIKit

class TagCell: UICollectionViewCell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        contentView.backgroundColor = .blue
        layer.masksToBounds = true
        layer.cornerRadius = 14

        contentView.addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4.0)
            .isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4.0)
            .isActive = true
        textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            .isActive = true
    }
}
