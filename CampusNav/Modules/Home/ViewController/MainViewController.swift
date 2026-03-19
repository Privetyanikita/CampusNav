//
//  MainViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit
import SnapKit
import SafariServices

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
    
    private let heroItems: [HeroItem] = HeroItem.makeMockData()
    private let serviceItems: [ServiceItem] = ServiceItem.makeMockData()
    private let newsItems: [MainNewsItem] = MainNewsItem.makeMockData()
    
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
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self, let section = MainSection(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .hero:
                return self.makeHeroSection()
            case .services:
                return self.makeServicesSection(layoutEnvironment: layoutEnvironment)
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
    
    private func makeServicesSection(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let horizontalInsets: CGFloat = 32
        let interGroupSpacing: CGFloat = 10
        let availableWidth = layoutEnvironment.container.effectiveContentSize.width - horizontalInsets
        let targetCardWidth = ((availableWidth - (interGroupSpacing * 2)) / 3).rounded(.down)
        let cardWidth = min(max(targetCardWidth, 130), 156)

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(cardWidth),
            heightDimension: .absolute(172)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = interGroupSpacing
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
        collectionView.deselectItem(at: indexPath, animated: true)

        guard
            let section = MainSection(rawValue: indexPath.section),
            let itemId = dataSource?.itemIdentifier(for: indexPath)
        else { return }

        switch section {
        case .hero:
            return
        case .services:
            guard
                let service = serviceItemsById[itemId],
                let url = service.url
            else { return }

            let browserViewController = SFSafariViewController(url: url)
            browserViewController.dismissButtonStyle = .close
            browserViewController.modalPresentationStyle = .pageSheet
            present(browserViewController, animated: true)
        case .news:
            guard let news = newsItemsById[itemId] else { return }
            let detailViewController = NewsDetailViewController(newsItem: news)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
