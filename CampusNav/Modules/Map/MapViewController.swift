//
//  MapViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit
import SnapKit

final class MapViewController: UIViewController {
    
    private let NameLabel: UILabel = {
        let element = UILabel()
        element.text = "что-то"
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground
    }
    
}

extension MapViewController {
    private func setupConstraints() {
    }
}
