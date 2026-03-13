//
//  ScheduleLessonViewCell.swift
//  CampusNav
//
//  Created by Nikita on 13.03.2026.
//

import UIKit
import SnapKit

final class ScheduleLessonCell: UITableViewCell {
    static let reuseID = "ScheduleLessonCell"

    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemGroupedBackground
        view.layer.cornerRadius = 14
        return view
    }()

    private let accentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        return view
    }()

    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 14
        return stack
    }()

    private let timeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 2
        return stack
    }()

    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()

    private let titleRowStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 8
        return stack
    }()

    private let tagsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 8
        return stack
    }()

    private let startTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        return label
    }()

    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()

    private let subjectLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()

    private let teacherRoomLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 2
        return label
    }()

    private let typeBadgeLabel: PaddedLabel = {
        let label = PaddedLabel(insets: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()

    private let statusBadgeLabel: PaddedLabel = {
        let label = PaddedLabel(insets: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()

    private let noteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with lesson: Lesson) {
        startTimeLabel.text = lesson.startTime
        endTimeLabel.text = lesson.endTime
        subjectLabel.text = lesson.subject
        teacherRoomLabel.text = "\(lesson.teacher) • \(lesson.room)"

        typeBadgeLabel.text = lesson.type.title
        typeBadgeLabel.textColor = lesson.type.tintColor
        typeBadgeLabel.backgroundColor = lesson.type.tintColor.withAlphaComponent(0.15)

        statusBadgeLabel.text = lesson.status.title
        statusBadgeLabel.textColor = lesson.status.tintColor
        statusBadgeLabel.backgroundColor = lesson.status.tintColor.withAlphaComponent(0.15)

        accentView.backgroundColor = lesson.type.tintColor

        if let note = lesson.note, !note.isEmpty {
            noteLabel.text = note
            noteLabel.isHidden = false
        } else {
            noteLabel.text = nil
            noteLabel.isHidden = true
        }
    }

    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(cardView)
        cardView.add(subviews: accentView, contentStack)

        contentStack.addArrangedSubview(timeStack)
        contentStack.addArrangedSubview(infoStack)

        timeStack.addArrangedSubview(startTimeLabel)
        timeStack.addArrangedSubview(endTimeLabel)

        infoStack.addArrangedSubview(titleRowStack)
        infoStack.addArrangedSubview(teacherRoomLabel)
        infoStack.addArrangedSubview(tagsStack)
        infoStack.addArrangedSubview(noteLabel)

        titleRowStack.addArrangedSubview(subjectLabel)
        titleRowStack.addArrangedSubview(statusBadgeLabel)

        tagsStack.addArrangedSubview(typeBadgeLabel)
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16))
        }

        accentView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(4)
        }

        contentStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalTo(accentView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
        }

        timeStack.snp.makeConstraints { make in
            make.width.equalTo(64)
        }

        statusBadgeLabel.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(24)
        }
    }
}
