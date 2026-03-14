//
//  MainModel.swift
//  CampusNav
//
//  Created by Nikita on 13.03.2026.
//

import Foundation

struct HeroItem: Hashable, Sendable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageSystemName: String
    
    static func makeMockData() -> [HeroItem] {
        return [
            HeroItem(
                title: "Поступление 2026",
                subtitle: "Проверьте сроки, проходные баллы и список документов",
                imageSystemName: "graduationcap.fill"
            ),
            HeroItem(
                title: "Олимпиады и конкурсы",
                subtitle: "Следите за новыми возможностями для абитуриентов",
                imageSystemName: "trophy.fill"
            ),
            HeroItem(
                title: "Расписание консультаций",
                subtitle: "Запишитесь на встречу с представителем факультета",
                imageSystemName: "calendar.badge.clock"
            )
        ]
    }
}

struct ServiceItem: Hashable, Sendable {
    let id = UUID()
    let title: String
    let imageSystemName: String
    
    static func makeMockData() -> [ServiceItem] {
        return [
            ServiceItem(title: "Приёмная комиссия", imageSystemName: "calendar"),
            ServiceItem(title: "Специальности", imageSystemName: "list.bullet.rectangle"),
            ServiceItem(title: "Дополнительные образовательные программы", imageSystemName: "person.3.fill"),
            ServiceItem(title: "Есть вопросы?", imageSystemName: "atom"),
            ServiceItem(title: "Запрос в Управление цифровых технологий", imageSystemName: "wrench.and.screwdriver.fill"),
            ServiceItem(title: "Образовательная система Moodle", imageSystemName: "book.fill"),
            ServiceItem(title: "Электронная библиотека", imageSystemName: "books.vertical.fill")
        ]
    }
}

struct MainNewsItem: Hashable, Sendable {
    let id = UUID()
    let title: String
    let details: String
    let imageSystemName: String
    
    static func makeMockData() -> [MainNewsItem] {
        return [
            MainNewsItem(
                title: "Открыта регистрация на День открытых дверей",
                details: "Регистрация доступна до 22 марта. На мероприятии расскажут о программах обучения, стипендиях и возможностях практики.",
                imageSystemName: "person.3.fill"
            ),
            MainNewsItem(
                title: "Стартовал набор в проектные команды",
                details: "Студенты могут подать заявку в проектные команды кафедр и партнёрских компаний. Приём заявок открыт до конца месяца.",
                imageSystemName: "hammer.fill"
            ),
            MainNewsItem(
                title: "Обновлён график весенней сессии",
                details: "В личном кабинете опубликован новый график сессии. Проверьте даты зачётов и экзаменов в разделе расписания.",
                imageSystemName: "doc.text.fill"
            ),
            MainNewsItem(
                title: "Университет получил грант на развитие ИИ-лаборатории",
                details: "Грант направят на расширение вычислительной инфраструктуры и запуск новых исследовательских треков.",
                imageSystemName: "cpu.fill"
            )
        ]
    }
}

enum MainSection: Int, CaseIterable, Sendable {
    case hero
    case services
    case news

    var title: String? {
        switch self {
        case .hero:
            return nil
        case .services:
            return "Полезные сервисы"
        case .news:
            return "Новости"
        }
    }
}
