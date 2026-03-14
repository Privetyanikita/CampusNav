//
//  SectionHeaderReusableView.swift
//  CampusNav
//
//  Created by Nikita on 13.03.2026.
//

import UIKit
import SnapKit

final class SectionHeaderView: UICollectionReusableView {

    private let titleLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 22, weight: .bold)
        element.textColor = .label
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

    func configure(title: String) {
        titleLabel.text = title
    }

    private func setupViews() {
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(2)
        }
    }
}
