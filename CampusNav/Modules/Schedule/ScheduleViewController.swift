//
//  ScheduleViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit

final class ScheduleViewController: UIViewController {
    private let contentView = ScheduleView()
    private let mockScheduleFactory = ScheduleMockFactory()

    private var schedule: [ScheduleDay] = []
    private var selectedDayIndex = 0

    private var selectedLessons: [Lesson] {
        guard schedule.indices.contains(selectedDayIndex) else { return [] }
        return schedule[selectedDayIndex].lessons
    }

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureMockData()
        configureTableView()
        configureDaySelector()
        updateDayContent()
    }

    private func configureTableView() {
        contentView.tableView.register(ScheduleLessonCell.self, forCellReuseIdentifier: ScheduleLessonCell.reuseID)
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self

        contentView.daySelector.addTarget(self, action: #selector(daySelectorChanged), for: .valueChanged)
    }

    private func configureMockData() {
        schedule = mockScheduleFactory.makeMockSchedule()

        let calendar = Calendar(identifier: .gregorian)
        let weekday = calendar.component(.weekday, from: Date())
        let mappedIndex = weekday == 1 ? 0 : max(0, weekday - 2)
        selectedDayIndex = min(mappedIndex, max(schedule.count - 1, 0))
    }

    private func configureDaySelector() {
        contentView.configureDaySelector(with: schedule, selectedIndex: selectedDayIndex)
    }

    @objc private func daySelectorChanged() {
        selectedDayIndex = contentView.daySelector.selectedSegmentIndex
        updateDayContent()
    }

    private func updateDayContent() {
        guard schedule.indices.contains(selectedDayIndex) else { return }

        let day = schedule[selectedDayIndex]
        let lessons = day.lessons
        let summary = makeSummaryText(for: lessons)

        contentView.updateSummary(title: day.fullDateTitle.capitalized, subtitle: summary)
        contentView.setEmptyStateVisible(lessons.isEmpty)
        contentView.tableView.reloadData()
    }

    private func makeSummaryText(for lessons: [Lesson]) -> String {
        guard let first = lessons.first, let last = lessons.last else {
            return "Свободный день без занятий."
        }

        let count = lessons.count
        return "\(count) \(lessonWord(for: count)) • с \(first.startTime) до \(last.endTime)"
    }

    private func lessonWord(for count: Int) -> String {
        let mod10 = count % 10
        let mod100 = count % 100

        if mod10 == 1 && mod100 != 11 {
            return "пара"
        }

        if (2...4).contains(mod10) && !(12...14).contains(mod100) {
            return "пары"
        }

        return "пар"
    }
}

extension ScheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectedLessons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ScheduleLessonCell.reuseID,
                for: indexPath
            ) as? ScheduleLessonCell
        else {
            return UITableViewCell()
        }

        let lesson = selectedLessons[indexPath.row]
        cell.configure(with: lesson)
        return cell
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
