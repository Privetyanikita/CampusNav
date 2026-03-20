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
        
        deadlineLabel.font = .systemFont(ofSize: 13, weight: .medium)
        deadlineLabel.textColor = .systemRed
        
        taskDescriptionLabel.numberOfLines = 0
        taskDescriptionLabel.font = .systemFont(ofSize: 15)
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 6
        
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
        deadlineLabel.text = "Срок сдачи: \(deadline)"
        taskDescriptionLabel.text = task
        deadlineLabel.textColor = isUrgent ? .systemRed : .systemGreen
    }
    
    private func setupConstraints() {
        deadlineLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
            
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-12)
            make.trailing.lessThanOrEqualTo(deadlineLabel.snp.leading).offset(-10)
        }
        [teacherLabel, subjectLabel, taskDescriptionLabel].forEach {
            $0.textAlignment = .left
        }
    }
}