//
//  TasksViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit
import SnapKit

final class TasksViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
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
