//
//  Views.swift
//  CampusNav
//
//  Created by Nikita on 13.03.2026.
//

import UIKit
import SnapKit

final class ScheduleView: UIView {
    let daySelector: UISegmentedControl = {
        let control = UISegmentedControl()
        control.selectedSegmentTintColor = .systemBlue
        control.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        control.setTitleTextAttributes([.foregroundColor: UIColor.label], for: .normal)
        return control
    }()

    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 148
        tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 20, right: 0)
        return tableView
    }()

    private let summaryCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemGroupedBackground
        view.layer.cornerRadius = 16
        return view
    }()

    private let summaryTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .label
        return label
    }()

    private let summarySubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    private let emptyStateStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.isHidden = true
        return stack
    }()

    private let emptyStateImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "calendar.badge.exclamationmark"))
        imageView.tintColor = .tertiaryLabel
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 36, weight: .regular)
        return imageView
    }()

    private let emptyStateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "На этот день пар нет"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let emptyStateSubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Можно посвятить время самостоятельной подготовке."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureDaySelector(with days: [ScheduleDay], selectedIndex: Int) {
        daySelector.removeAllSegments()
        for (index, day) in days.enumerated() {
            daySelector.insertSegment(withTitle: day.segmentTitle, at: index, animated: false)
        }
        daySelector.selectedSegmentIndex = selectedIndex
    }

    func updateSummary(title: String, subtitle: String) {
        summaryTitleLabel.text = title
        summarySubtitleLabel.text = subtitle
    }

    func setEmptyStateVisible(_ isVisible: Bool) {
        tableView.isHidden = isVisible
        emptyStateStack.isHidden = !isVisible
    }

    private func setupViews() {
        backgroundColor = .systemGroupedBackground
        add(subviews: summaryCardView, daySelector, tableView, emptyStateStack)

        summaryCardView.add(subviews: summaryTitleLabel, summarySubtitleLabel)

        emptyStateStack.addArrangedSubview(emptyStateImageView)
        emptyStateStack.addArrangedSubview(emptyStateTitleLabel)
        emptyStateStack.addArrangedSubview(emptyStateSubtitleLabel)
    }

    private func setupConstraints() {
        summaryCardView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        summaryTitleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }

        summarySubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(summaryTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }

        daySelector.snp.makeConstraints { make in
            make.top.equalTo(summaryCardView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(34)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(daySelector.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }

        emptyStateStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(tableView.snp.centerY).offset(-16)
            make.leading.greaterThanOrEqualToSuperview().offset(24)
            make.trailing.lessThanOrEqualToSuperview().offset(-24)
        }
    }
}
