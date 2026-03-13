//
//  ScheduleModels.swift
//  CampusNav
//
//  Created by Nikita on 13.03.2026.
//

import UIKit

enum LessonType {
    case lecture
    case seminar
    case lab
    case workshop
    
    var title: String {
        switch self {
        case .lecture:
            return "Лекция"
        case .seminar:
            return "Семинар"
        case .lab:
            return "Лабораторная"
        case .workshop:
            return "Практика"
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .lecture:
            return .systemBlue
        case .seminar:
            return .systemOrange
        case .lab:
            return .systemPurple
        case .workshop:
            return .systemGreen
        }
    }
}

enum LessonStatus {
    case upcoming
    case inProgress
    case completed
    case canceled
    
    var title: String {
        switch self {
        case .upcoming:
            return "Скоро"
        case .inProgress:
            return "Сейчас"
        case .completed:
            return "Завершена"
        case .canceled:
            return "Отменена"
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .upcoming:
            return .systemBlue
        case .inProgress:
            return .systemGreen
        case .completed:
            return .systemGray
        case .canceled:
            return .systemRed
        }
    }
}

struct Lesson {
    let startTime: String
    let endTime: String
    let subject: String
    let teacher: String
    let room: String
    let type: LessonType
    let status: LessonStatus
    let note: String?
}

private extension Lesson {
    func with(status: LessonStatus) -> Lesson {
        Lesson(
            startTime: startTime,
            endTime: endTime,
            subject: subject,
            teacher: teacher,
            room: room,
            type: type,
            status: status,
            note: note
        )
    }
}

struct ScheduleDay {
    let segmentTitle: String
    let fullDateTitle: String
    let lessons: [Lesson]
}

struct ScheduleMockFactory {
    private let segmentFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "EE dd"
        return formatter
    }()
    
    private let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "EEEE, d MMMM"
        return formatter
    }()
    
    func makeMockSchedule(referenceDate: Date = Date()) -> [ScheduleDay] {
        let calendar = Calendar(identifier: .gregorian)
        let now = referenceDate
        let currentWeekday = calendar.component(.weekday, from: referenceDate)
        let offsetToMonday = (currentWeekday + 5) % 7
        let monday = calendar.date(
            byAdding: .day,
            value: -offsetToMonday,
            to: calendar.startOfDay(for: referenceDate)
        ) ?? referenceDate
        
        let lessonsByDay: [[Lesson]] = [
            [
                Lesson(
                    startTime: "09:00",
                    endTime: "10:30",
                    subject: "Высшая математика",
                    teacher: "Иванов И.И.",
                    room: "А-312",
                    type: .lecture,
                    status: .upcoming,
                    note: "Подготовить вопросы по теме «Интегралы»."
                ),
                Lesson(
                    startTime: "10:45",
                    endTime: "12:15",
                    subject: "Физика",
                    teacher: "Петрова Е.С.",
                    room: "Лаб-204",
                    type: .lab,
                    status: .upcoming,
                    note: "Нужен лабораторный халат."
                ),
                Lesson(
                    startTime: "13:00",
                    endTime: "14:30",
                    subject: "Английский язык",
                    teacher: "Smith A.",
                    room: "B-118",
                    type: .seminar,
                    status: .upcoming,
                    note: nil
                ),
                Lesson(
                    startTime: "14:45",
                    endTime: "16:15",
                    subject: "Программирование",
                    teacher: "Сидоров П.Н.",
                    room: "Онлайн (MS Teams)",
                    type: .workshop,
                    status: .upcoming,
                    note: "Крайний срок: сдать лабораторную до 23:59."
                )
            ],
            [
                Lesson(
                    startTime: "09:00",
                    endTime: "10:30",
                    subject: "История",
                    teacher: "Орлова М.В.",
                    room: "С-105",
                    type: .lecture,
                    status: .upcoming,
                    note: nil
                ),
                Lesson(
                    startTime: "12:30",
                    endTime: "14:00",
                    subject: "Базы данных",
                    teacher: "Кузнецов Д.А.",
                    room: "D-220",
                    type: .workshop,
                    status: .upcoming,
                    note: "Принести ноутбук."
                ),
                Lesson(
                    startTime: "14:15",
                    endTime: "15:45",
                    subject: "Философия",
                    teacher: "Громов В.И.",
                    room: "А-205",
                    type: .seminar,
                    status: .upcoming,
                    note: nil
                )
            ],
            [],
            [
                Lesson(
                    startTime: "10:45",
                    endTime: "12:15",
                    subject: "Алгоритмы",
                    teacher: "Соколов Н.М.",
                    room: "D-118",
                    type: .lecture,
                    status: .upcoming,
                    note: "Повторить сортировки и графы."
                ),
                Lesson(
                    startTime: "13:00",
                    endTime: "14:30",
                    subject: "Компьютерные сети",
                    teacher: "Голубев А.О.",
                    room: "Лаб-107",
                    type: .lab,
                    status: .upcoming,
                    note: nil
                )
            ],
            [
                Lesson(
                    startTime: "09:00",
                    endTime: "10:30",
                    subject: "Экономика",
                    teacher: "Назарова О.В.",
                    room: "B-304",
                    type: .lecture,
                    status: .upcoming,
                    note: nil
                ),
                Lesson(
                    startTime: "10:45",
                    endTime: "12:15",
                    subject: "Проектный практикум",
                    teacher: "Морозов К.С.",
                    room: "Коворкинг 2 этаж",
                    type: .workshop,
                    status: .canceled,
                    note: "Пара перенесена на следующую неделю."
                ),
                Lesson(
                    startTime: "13:00",
                    endTime: "14:30",
                    subject: "Физическая культура",
                    teacher: "Чернов А.Г.",
                    room: "Спортзал",
                    type: .seminar,
                    status: .upcoming,
                    note: "Спортивная форма обязательна."
                )
            ],
            [
                Lesson(
                    startTime: "11:00",
                    endTime: "12:30",
                    subject: "Факультатив: UX/UI",
                    teacher: "Лебедева Р.А.",
                    room: "Онлайн (Zoom)",
                    type: .workshop,
                    status: .upcoming,
                    note: "Участие добровольное."
                )
            ]
        ]
        
        return lessonsByDay.enumerated().map { index, lessons in
            let date = calendar.date(byAdding: .day, value: index, to: monday) ?? referenceDate
            let segmentTitle = segmentFormatter.string(from: date).capitalized
            let fullDateTitle = fullDateFormatter.string(from: date)
            let resolvedLessons = lessons.map { lesson in
                let status = resolveStatus(for: lesson, lessonDay: date, now: now, calendar: calendar)
                return lesson.with(status: status)
            }
            return ScheduleDay(segmentTitle: segmentTitle, fullDateTitle: fullDateTitle, lessons: resolvedLessons)
        }
    }
    
    private func resolveStatus(for lesson: Lesson, lessonDay: Date, now: Date, calendar: Calendar) -> LessonStatus {
        if lesson.status == .canceled {
            return .canceled
        }
        
        guard
            let startDate = lessonDate(from: lesson.startTime, on: lessonDay, calendar: calendar),
            let endDate = lessonDate(from: lesson.endTime, on: lessonDay, calendar: calendar)
        else {
            return lesson.status
        }
        
        if now >= endDate {
            return .completed
        }
        
        if now >= startDate {
            return .inProgress
        }
        
        return .upcoming
    }
    
    private func lessonDate(from time: String, on day: Date, calendar: Calendar) -> Date? {
        let components = time.split(separator: ":")
        guard
            components.count == 2,
            let hour = Int(components[0]),
            let minute = Int(components[1])
        else {
            return nil
        }
        
        return calendar.date(
            bySettingHour: hour,
            minute: minute,
            second: 0,
            of: day
        )
    }
}
