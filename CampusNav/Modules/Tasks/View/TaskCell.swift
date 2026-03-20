//
//  TaskCell.swift
//  CampusNav
//
//  Created by Nikita on 20.03.2026.
//

import UIKit
import SnapKit

final class TaskCell: UITableViewCell {
    
    let teacherLabel = UILabel()
    let subjectLabel = UILabel()
    let deadlineLabel = UILabel()
    let taskDescriptionLabel = UILabel()
    let mainStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        teacherLabel.font = .systemFont(ofSize: 14)
        teacherLabel.textColor = .secondaryLabel
        subjectLabel.font = .boldSystemFont(ofSize: 16)
        
        deadlineLabel.font = .systemFont(ofSize: 12, weight: .bold)
        deadlineLabel.textAlignment = .center
        deadlineLabel.layer.cornerRadius = 6
        deadlineLabel.clipsToBounds = true
        
        taskDescriptionLabel.numberOfLines = 0
        taskDescriptionLabel.font = .systemFont(ofSize: 15)
        taskDescriptionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 6
        mainStackView.alignment = .fill
        
        [subjectLabel, teacherLabel, taskDescriptionLabel].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(mainStackView)
        contentView.addSubview(deadlineLabel)
        setupConstraints()
    }
    
    func configure(teacher: String, subject: String, deadline: String, task: String, isUrgent: Bool) {
        teacherLabel.text = teacher
        subjectLabel.text = subject
        deadlineLabel.text = " \(deadline) "
        taskDescriptionLabel.text = task
        let baseColor: UIColor = isUrgent ? .systemRed : .systemGreen
        
        deadlineLabel.textColor = baseColor
        deadlineLabel.backgroundColor = baseColor.withAlphaComponent(0.15)
    }
    
    private func setupConstraints() {
        deadlineLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(60)
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.equalToSuperview().offset(-100)
        }
        [teacherLabel, subjectLabel, taskDescriptionLabel].forEach {
            $0.textAlignment = .left
        }
    }
}
