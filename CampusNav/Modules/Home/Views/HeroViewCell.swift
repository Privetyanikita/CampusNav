//
//  HeroViewCell.swift
//  CampusNav
//
//  Created by Nikita on 13.03.2026.
//

import UIKit
import SnapKit

final class HeroCell: UICollectionViewCell {

    private let cardView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 24
        element.clipsToBounds = true
        return element
    }()

    private let iconBackgroundView: UIView = {
        let element = UIView()
        element.layer.cornerRadius = 28
        element.clipsToBounds = true
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
        element.font = .boldSystemFont(ofSize: 24)
        element.textColor = .white
        element.numberOfLines = 2
        return element
    }()

    private let subtitleLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 15, weight: .medium)
        element.textColor = UIColor.white.withAlphaComponent(0.92)
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

    func configure(with item: HeroItem, paletteIndex: Int) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        iconImageView.image = UIImage(systemName: item.imageSystemName)

        let palette: [UIColor] = [
            UIColor(red: 0.16, green: 0.35, blue: 0.83, alpha: 1.0),
            UIColor(red: 0.05, green: 0.56, blue: 0.66, alpha: 1.0),
            UIColor(red: 0.18, green: 0.45, blue: 0.38, alpha: 1.0)
        ]

        let backgroundColor = palette[paletteIndex % palette.count]
        cardView.backgroundColor = backgroundColor
        iconBackgroundView.backgroundColor = backgroundColor.withAlphaComponent(0.22)
    }

    private func setupViews() {
        contentView.backgroundColor = .clear

        contentView.addSubview(cardView)
        cardView.add(subviews: iconBackgroundView, titleLabel, subtitleLabel)
        iconBackgroundView.addSubview(iconImageView)
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        iconBackgroundView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 56, height: 56))
            make.top.leading.equalToSuperview().inset(18)
        }

        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 30, height: 30))
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(iconBackgroundView.snp.bottom).offset(14)
        }

        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(18)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
}
