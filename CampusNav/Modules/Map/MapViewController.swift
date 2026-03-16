//
//  MapViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit
import SnapKit
import Foundation

// MARK: - MapViewController

final class MapViewController: UIViewController {

    // MARK: - Data

    private let buildings: [Building] = [
        // latitude/longitude координаты геопозиции
        Building(title: "Факультет экономики, управления и права \n Корпус 1", subtitle: "Перейти", latitude: 47.101420, longitude: 37.525576),
        Building(title: "Факультет филологии и массовых коммуникаций \n Корпус 2", subtitle: "Перейти", latitude: 47.102119, longitude: 37.525756),
        Building(title: "Педагогический факультет \n Корпус 3-4", subtitle: "Перейти", latitude: 47.109443, longitude: 37.530238),
        Building(title: "Факультет гуманитарных и социальных наук \n Корпус 5", subtitle: "Перейти", latitude: 47.099420, longitude: 37.536302),
    ]

    // MARK: - UI

    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.alwaysBounceVertical = true
        sv.showsVerticalScrollIndicator = false
        return sv
    }()

    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 12
        sv.alignment = .fill
        return sv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup

    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground

        view.addSubview(scrollView)
        scrollView.addSubview(stackView)

        for (index, building) in buildings.enumerated() {
            let card = makeBuildingCard(building: building, tag: index)
            stackView.addArrangedSubview(card)
        }
    }

    // MARK: - Card Factory

    private func makeBuildingCard(building: Building, tag: Int) -> UIView {
        let container = UIView()
        container.backgroundColor = .secondarySystemGroupedBackground
        container.layer.cornerRadius = 12
        container.layer.borderWidth = 0.5
        container.layer.borderColor = UIColor.separator.cgColor
        container.tag = tag

        let titleLabel = UILabel()
        titleLabel.text = building.title
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        let subtitleLabel = UILabel()
        subtitleLabel.text = building.subtitle
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .regular)
        subtitleLabel.textColor = .systemBlue
        subtitleLabel.textAlignment = .center

        let innerStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        innerStack.axis = .vertical
        innerStack.spacing = 4
        innerStack.alignment = .center
        innerStack.isUserInteractionEnabled = false

        container.addSubview(innerStack)

        innerStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16))
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(buildingCardTapped(_:)))
        container.addGestureRecognizer(tap)

        return container
    }

    // MARK: - Actions

    @objc private func buildingCardTapped(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        let building = buildings[tag]
        openMaps(latitude: building.latitude, longitude: building.longitude, name: building.title)
    }

    private func openMaps(latitude: Double, longitude: Double, name: String) {
        let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name

        // Apple Maps
        if let url = URL(string: "http://maps.apple.com/?ll=\(latitude),\(longitude)&q=\(encodedName)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return
        }

        // Google Maps
        if let url = URL(string: "comgooglemaps://?q=\(latitude),\(longitude)&label=\(encodedName)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return
        }

        // Яндекс Карты
        if let url = URL(string: "yandexmaps://maps.yandex.ru/?pt=\(longitude),\(latitude)&z=17&l=map"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
            return
        }

        // Fallback — браузер Google Maps
        if let url = URL(string: "https://www.google.com/maps/search/?api=1&query=\(latitude),\(longitude)") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - Constraints

extension MapViewController {
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
            make.width.equalToSuperview().offset(-32)
        }
    }
}
