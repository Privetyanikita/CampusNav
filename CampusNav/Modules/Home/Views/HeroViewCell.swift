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

    private let backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFill
        element.clipsToBounds = true
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
        backgroundImageView.image = item.image
    }

    private func setupViews() {
        contentView.backgroundColor = .clear

        contentView.addSubview(cardView)
        cardView.add(subviews: backgroundImageView)
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
