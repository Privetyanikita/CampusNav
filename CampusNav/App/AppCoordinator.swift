//
//  AppCoordinator.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit

final class AppCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let tabBarCoordinator = TabBarCoordinator()
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()

        window.rootViewController = tabBarCoordinator.tabBarController
        window.makeKeyAndVisible()
    }
}
