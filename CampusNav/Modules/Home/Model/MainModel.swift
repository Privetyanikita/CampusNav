//
//  MainModel.swift
//  CampusNav
//
//  Created by Nikita on 13.03.2026.
//

import UIKit

struct HeroItem: Hashable, Sendable {
    let id = UUID()
    let image: UIImage?
    
    static func makeMockData() -> [HeroItem] {
        return [
            HeroItem(image: Images.NewsCell.newsImage),
            HeroItem(image: Images.NewsCell.newsTwoImage),
            HeroItem(image: Images.NewsCell.newsThreeImage),
            HeroItem(image: Images.NewsCell.newsFourImage)
        ]
    }
}

struct ServiceItem: Hashable, Sendable {
    let id = UUID()
    let title: String
    let imageSystemName: String
    let urlString: String

    var url: URL? {
        URL(string: urlString)
    }
    
    static func makeMockData() -> [ServiceItem] {
        return [
            ServiceItem(
                title: "Приёмная комиссия",
                imageSystemName: "calendar",
                urlString: "https://mgumariupol.ru/abitur/priemnaya-komissiya/"
            ),
            ServiceItem(
                title: "Специальности",
                imageSystemName: "list.bullet.rectangle",
                urlString: "https://mgumariupol.ru/abitur/specialties/"
            ),
            ServiceItem(
                title: "Дополнительные образовательные программы",
                imageSystemName: "person.3.fill",
                urlString: "https://mgumariupol.ru/life/struktura-universiteta/otdel-profilnogo-i-dopolnitelnogo-obrazovaniya/"
            ),
            ServiceItem(
                title: "Есть вопросы?",
                imageSystemName: "atom",
                urlString: "https://mgumariupol.ru/voprosy-i-otvety/"
            ),
            ServiceItem(
                title: "Запрос в Управление цифровых технологий",
                imageSystemName: "wrench.and.screwdriver.fill",
                urlString: "http://help.mgu.corp/"
            ),
            ServiceItem(
                title: "Образовательная система Moodle",
                imageSystemName: "book.fill",
                urlString: "https://skif.mgumariupol.ru/"
            ),
            ServiceItem(
                title: "Электронная библиотека",
                imageSystemName: "books.vertical.fill",
                urlString: "http://ebd.mgumariupol.ru:85/cgi-bin/irbis64r_plus/cgiirbis_64_ft.exe?C21COM=F&I21DBN=EK_FULLTEXT&P21DBN=EK&Z21ID=&S21CNR=5"
            )
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
