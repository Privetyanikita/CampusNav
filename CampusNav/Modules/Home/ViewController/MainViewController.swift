//
//  MainViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit
import SnapKit

private struct HeroItem: Hashable, Sendable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageSystemName: String
}

private struct ServiceItem: Hashable, Sendable {
    let id = UUID()
    let title: String
    let imageSystemName: String
}

struct MainNewsItem: Hashable, Sendable {
    let id = UUID()
    let title: String
    let details: String
    let imageSystemName: String
}

private enum MainSection: Int, CaseIterable, Sendable {
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

final class MainViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let element = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        element.backgroundColor = .systemGroupedBackground
        element.delegate = self
        element.alwaysBounceVertical = true
        return element
    }()

    private typealias DataSource = UICollectionViewDiffableDataSource<Int, UUID>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, UUID>

    private var dataSource: DataSource?

    private let heroItems: [HeroItem] = [
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

    private let serviceItems: [ServiceItem] = [
        ServiceItem(title: "Приёмная комиссия", imageSystemName: "calendar"),
        ServiceItem(title: "Специальности", imageSystemName: "list.bullet.rectangle"),
        ServiceItem(title: "Дополнительные образовательные программы", imageSystemName: "person.3.fill"),
        ServiceItem(title: "Есть вопросы?", imageSystemName: "atom"),
        ServiceItem(title: "Запрос в Управление цифровых технологий", imageSystemName: "wrench.and.screwdriver.fill"),
        ServiceItem(title: "Образовательная система Moodle", imageSystemName: "book.fill"),
        ServiceItem(title: "Электронная библиотека", imageSystemName: "books.vertical.fill")
    ]

    private let newsItems: [MainNewsItem] = [
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

    private lazy var heroItemsById = Dictionary(uniqueKeysWithValues: heroItems.map { ($0.id, $0) })
    private lazy var serviceItemsById = Dictionary(uniqueKeysWithValues: serviceItems.map { ($0.id, $0) })
    private lazy var newsItemsById = Dictionary(uniqueKeysWithValues: newsItems.map { ($0.id, $0) })

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureDataSource()
        applyInitialSnapshot()
    }

    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self, let section = MainSection(rawValue: sectionIndex) else { return nil }

            switch section {
            case .hero:
                return self.makeHeroSection()
            case .services:
                return self.makeServicesSection()
            case .news:
                return self.makeNewsSection()
            }
        }
    }

    private func makeHeroSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.9),
            heightDimension: .absolute(215)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 14
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 0, bottom: 20, trailing: 0)

        return section
    }

    private func makeServicesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(130),
            heightDimension: .absolute(160)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16)
        section.boundarySupplementaryItems = [makeHeaderItem()]

        return section
    }

    private func makeNewsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(94)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 16)
        section.boundarySupplementaryItems = [makeHeaderItem()]

        return section
    }

    private func makeHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(38)
        )

        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }

    private func configureDataSource() {
        let heroRegistration = UICollectionView.CellRegistration<HeroCell, HeroItem> { cell, indexPath, item in
            cell.configure(with: item, paletteIndex: indexPath.item)
        }

        let serviceRegistration = UICollectionView.CellRegistration<ServiceCell, ServiceItem> { cell, _, item in
            cell.configure(with: item)
        }

        let newsRegistration = UICollectionView.CellRegistration<NewsCell, MainNewsItem> { cell, _, item in
            cell.configure(with: item)
        }

        let headerRegistration = UICollectionView.SupplementaryRegistration<SectionHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { [weak self] supplementaryView, _, indexPath in
            guard
                let self,
                let section = MainSection(rawValue: indexPath.section)
            else { return }

            supplementaryView.configure(title: section.title ?? "")
        }

        dataSource = DataSource(collectionView: collectionView) { [weak self] (collectionView: UICollectionView, indexPath: IndexPath, itemId: UUID) -> UICollectionViewCell? in
            guard
                let self,
                let section = MainSection(rawValue: indexPath.section)
            else { return nil }

            switch section {
            case .hero:
                guard let heroItem = self.heroItemsById[itemId] else { return nil }
                return collectionView.dequeueConfiguredReusableCell(
                    using: heroRegistration,
                    for: indexPath,
                    item: heroItem
                )
            case .services:
                guard let serviceItem = self.serviceItemsById[itemId] else { return nil }
                return collectionView.dequeueConfiguredReusableCell(
                    using: serviceRegistration,
                    for: indexPath,
                    item: serviceItem
                )
            case .news:
                guard let newsItem = self.newsItemsById[itemId] else { return nil }
                return collectionView.dequeueConfiguredReusableCell(
                    using: newsRegistration,
                    for: indexPath,
                    item: newsItem
                )
            }
        }

        dataSource?.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            _ = kind
            return collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration,
                for: indexPath
            )
        }
    }

    private func applyInitialSnapshot() {
        var snapshot = Snapshot()

        snapshot.appendSections(MainSection.allCases.map(\.rawValue))
        snapshot.appendItems(heroItems.map(\.id), toSection: MainSection.hero.rawValue)
        snapshot.appendItems(serviceItems.map(\.id), toSection: MainSection.services.rawValue)
        snapshot.appendItems(newsItems.map(\.id), toSection: MainSection.news.rawValue)

        dataSource?.apply(snapshot, animatingDifferences: false)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let section = MainSection(rawValue: indexPath.section),
            section == .news,
            let itemId = dataSource?.itemIdentifier(for: indexPath),
            let news = newsItemsById[itemId]
        else {
            return
        }

        let detailViewController = NewsDetailViewController(newsItem: news)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

private final class NewsCell: UICollectionViewCell {

    private let cardView: UIView = {
        let element = UIView()
        element.backgroundColor = .secondarySystemGroupedBackground
        element.layer.cornerRadius = 16
        return element
    }()

    private let thumbnailView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.tintColor = UIColor(red: 0.17, green: 0.39, blue: 0.84, alpha: 1.0)
        element.backgroundColor = UIColor(red: 0.17, green: 0.39, blue: 0.84, alpha: 0.08)
        element.layer.cornerRadius = 12
        element.clipsToBounds = true
        return element
    }()

    private let titleLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 16, weight: .semibold)
        element.textColor = .label
        element.numberOfLines = 2
        return element
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with item: MainNewsItem) {
        titleLabel.text = item.title
        thumbnailView.image = UIImage(systemName: item.imageSystemName)
    }

    private func setupViews() {
        contentView.backgroundColor = .clear

        contentView.addSubview(cardView)
        cardView.add(subviews: thumbnailView, titleLabel)
    }

    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        thumbnailView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 74, height: 74))
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(thumbnailView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
        }
    }
}

private final class SectionHeaderView: UICollectionReusableView {

    private let titleLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 22, weight: .bold)
        element.textColor = .label
        return element
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String) {
        titleLabel.text = title
    }

    private func setupViews() {
        addSubview(titleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(2)
        }
    }
}
