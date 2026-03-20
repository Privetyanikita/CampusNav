//
//  MapViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit
import SnapKit

// MARK: - MapViewController

final class MapViewController: UIViewController {

    // MARK: - Data

    private let buildings: [Building] = [
        Building(title: "Факультет экономики, управления и права \n Корпус 1", subtitle: "Перейти", latitude: 47.101420, longitude: 37.525576, imageAssetName: Images.CampusPhotoCell.firstImage),
        Building(title: "Факультет филологии и массовых коммуникаций \n Корпус 2", subtitle: "Перейти", latitude: 47.102119, longitude: 37.525756, imageAssetName: Images.CampusPhotoCell.secondImage),
        Building(title: "Педагогический факультет \n Корпус 3-4", subtitle: "Перейти", latitude: 47.109443, longitude: 37.530238, imageAssetName: Images.CampusPhotoCell.thirdImage),
        Building(title: "Факультет гуманитарных и социальных наук \n Корпус 5", subtitle: "Перейти", latitude: 47.099420, longitude: 37.536302, imageAssetName: Images.CampusPhotoCell.fifthImage),
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

        let textStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.alignment = .center
        textStack.isUserInteractionEnabled = false
        
        let mainStack = UIStackView()
        mainStack.axis = .vertical
        mainStack.spacing = 12
        mainStack.alignment = .fill
        mainStack.isUserInteractionEnabled = false
        
        if let assetName = building.imageAssetName {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 8
            imageView.backgroundColor = .tertiarySystemGroupedBackground
            imageView.snp.makeConstraints { make in
                make.height.equalTo(140)
            }
            mainStack.addArrangedSubview(imageView)
            
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.color = .secondaryLabel
            activityIndicator.hidesWhenStopped = true
            imageView.addSubview(activityIndicator)
            activityIndicator.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            activityIndicator.startAnimating()
            
            DispatchQueue.global(qos: .userInitiated).async {
                guard let image = UIImage(named: assetName) else {
                    DispatchQueue.main.async {
                        activityIndicator.stopAnimating()
                    }
                    return
                }
                let renderer = UIGraphicsImageRenderer(size: image.size)
                let decoded = renderer.image { _ in
                    image.draw(at: .zero)
                }
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    UIView.transition(with: imageView, duration: 0.2, options: .transitionCrossDissolve) {
                        imageView.image = decoded
                    }
                }
            }
        }
        
        mainStack.addArrangedSubview(textStack)

        container.addSubview(mainStack)

        mainStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16))
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(buildingCardTapped(_:)))
        container.addGestureRecognizer(tap)

        return container
    }
}
