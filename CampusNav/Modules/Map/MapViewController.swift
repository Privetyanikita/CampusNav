//
//  MapViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit
import SnapKit

// MARK: - Building Model

private struct Building {
    let title: String
    let subtitle: String
    // TODO: Замените координаты на реальные
    let latitude: Double
    let longitude: Double
}

// MARK: - MapViewController

final class MapViewController: UIViewController {

    // MARK: - Data

    private let buildings: [Building] = [
        // ⬇️ КООРДИНАТЫ: замените latitude/longitude на реальные значения
        Building(title: "ФЭУП - Корпус 1", subtitle: "Перейти", latitude: 47.1013399, longitude: 37.5248076),
        Building(title: "ФФМК - Корпус 2", subtitle: "Перейти", latitude: 0.0, longitude: 0.0),
        Building(title: "ПФ - Корпус 3-4", subtitle: "Перейти", latitude: 0.0, longitude: 0.0),
        Building(title: "ФГСН - Корпус 5", subtitle: "Перейти", latitude: 0.0, longitude: 0.0),
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
    }
    
}

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
