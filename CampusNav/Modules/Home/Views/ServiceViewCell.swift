//
//  ServiceViewCell.swift
//  CampusNav
//
//  Created by Nikita on 13.03.2026.
//

import UIKit
import SnapKit

final class ServiceCell: UICollectionViewCell {

    private let iconContainerView: UIView = {
        let element = UIView()
        element.backgroundColor = UIColor(red: 0.20, green: 0.39, blue: 0.86, alpha: 1.0)
        element.layer.cornerRadius = 34
        return element
    }()

    private let iconImageView: UIImageView = {
        let element = UIImageView()
        element.tintColor = .white
        element.contentMode = .scaleAspectFit
        return element
    }()

    private let titleLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 14, weight: .medium)
        element.textColor = .label
        element.numberOfLines = 3
        element.textAlignment = .center
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

    func configure(with item: ServiceItem) {
        titleLabel.text = item.title
        iconImageView.image = UIImage(systemName: item.imageSystemName)
    }

    private func setupViews() {
        contentView.backgroundColor = .clear

        contentView.add(subviews: iconContainerView, titleLabel)
        iconContainerView.addSubview(iconImageView)
    }

    private func setupConstraints() {
        iconContainerView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 68, height: 68))
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 32, height: 32))
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconContainerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
