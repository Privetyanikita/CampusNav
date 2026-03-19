//
//  TasksViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit
import SnapKit

// MARK: - TaskCell
class TaskCell: UITableViewCell {
    
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

// MARK: - TasksViewController
final class TasksViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // Временные данные для проверки
    private let testTasks = [
        (t: "Сидоров И.И.", s: "История", d: "Сегодня 23:30", task: "Видео и доклад", isUrgent: false, n: "Нужно посмотреть ролик на Дзен про Первую мировую и составить конспект на 2 страницы."),
        (t: "Иванова Н.Ю.", s: "Английский", d: "Вт. 00:00", task: "Выполнить упражнение с файла", isUrgent: true, n: "Выучить 10 слов из словаря в 10 минут."),
        (t: "Петров Г.В.", s: "Физика", d: "Вчера 18:30", task: "Выполнить лабораторную с файла.", isUrgent: false, n: "Рассмотреть тему Закон Ньютона и выполнить все задания по ней."),
        (t: "Иванюта Л.А.", s: "C++", d: "Пт. 15:00", task: "Практическая №5", isUrgent: true, n: "Реализовать класс SmartPointer и проверить утечки памяти через Valgrind.")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    private func setupViews() {
        title = "Задания"
        view.backgroundColor = .systemGroupedBackground
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
}

// MARK: - Extension Constraints
extension TasksViewController {
    func tableView(_ tableView: UITableView, heightForHeaderSection indexPath: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeadrInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - TableView DataSource
extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return testTasks.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else {
            return UITableViewCell()
        }
        
        let data = testTasks[indexPath.section]
        cell.configure(teacher: data.t, subject: data.s, deadline: data.d, task: data.task, isUrgent: data.isUrgent)
        cell.selectionStyle = .default
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedTask = testTasks[indexPath.section]
        
        let detailVC = TaskDetailViewController(task: selectedTask)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - TaskDetailViewController
final class TaskDetailViewController: UIViewController {
    private let task: (t: String, s: String, d: String, task: String, isUrgent: Bool, n: String)
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let subjectLabel = UILabel()
    private let infoStackView = UIStackView()
    private let descriptionLabel = UILabel()
    private let fullDescriptionLabel = UILabel()
    
    init(task: (t: String, s: String, d: String, task: String, isUrgent: Bool, n: String)) {
        self.task = task
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupUI()
        setupConstraints()
        configureData()
    }
    
    private func setupUI() {
        subjectLabel.font = .systemFont(ofSize: 28, weight: .bold)
        subjectLabel.numberOfLines = 0
        
        infoStackView.axis = .vertical
        infoStackView.spacing = 15
        
        descriptionLabel.font = .systemFont(ofSize: 18, weight: .bold)
        descriptionLabel.textColor = .label
        
        fullDescriptionLabel.font = .systemFont(ofSize: 16)
        fullDescriptionLabel.numberOfLines = 0
        fullDescriptionLabel.textColor = .label
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [subjectLabel, infoStackView, descriptionLabel, fullDescriptionLabel].forEach {
            contentView.addSubview($0) }
    }
    
    private func configureData() {
        subjectLabel.text = task.s
        descriptionLabel.text = task.task
        fullDescriptionLabel.text = task.n
        
        addInfoRow(icon: "person.fill", text: task.t, color: .systemBlue)
        addInfoRow(icon: "calendar", text: "Сдать до: \(task.d)", color: task.isUrgent ? .systemRed : .systemGreen)
    }
    private func addInfoRow(icon: String, text: String, color: UIColor) {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 10
        
        let imageView = UIImageView(image: UIImage(systemName: icon))
        imageView.tintColor = color
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { $0.size.equalTo(24) }
        
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(label)
        infoStackView.addArrangedSubview(container)
    }
}

extension TaskDetailViewController {
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        subjectLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        infoStackView.snp.makeConstraints { make in
            make.top.equalTo(subjectLabel.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(infoStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        fullDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(15) // Отступ от темы
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-30) // Теперь это нижний элемент [cite: 23]
        }
    }
}
