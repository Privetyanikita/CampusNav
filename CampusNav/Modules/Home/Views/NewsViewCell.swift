//
//  NewsViewCell.swift
//  CampusNav
//
//  Created by Nikita on 13.03.2026.
//

import UIKit
import SnapKit

final class NewsCell: UICollectionViewCell {

    private let cardView: UIView = {
        let element = UIView()
        element.backgroundColor = .secondarySystemGroupedBackground
        element.layer.cornerRadius = 16
        return element
    }()

    private let thumbnailView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.tintColor = UIColor(red: 0.17, green: 0.39, blue: 0.84, alpha: 1.0)
        element.backgroundColor = UIColor(red: 0.17, green: 0.39, blue: 0.84, alpha: 0.08)
        element.layer.cornerRadius = 12
        element.clipsToBounds = true
        return element
    }()

    private let titleLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 16, weight: .semibold)
        element.textColor = .label
        element.numberOfLines = 2
        return element
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: MainNewsItem) {
        titleLabel.text = item.title
        thumbnailView.image = UIImage(systemName: item.imageSystemName)
    }

    private func setupViews() {
        contentView.backgroundColor = .clear

        contentView.addSubview(cardView)
        cardView.add(subviews: thumbnailView, titleLabel)
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        thumbnailView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 74, height: 74))
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }
}
