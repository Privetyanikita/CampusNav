//
//  HomeViewController.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemGroupedBackground
    }
    
}

extension HomeViewController {
    private func setupConstraints() {
    }
}
