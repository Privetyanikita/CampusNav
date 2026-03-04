//
//  Coordinator.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
