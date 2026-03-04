//
//  TabBarCoordinator.swift
//  CampusNav
//
//  Created by Nikita on 04.03.2026.
//

import UIKit

final class TabBarCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    let tabBarController = UITabBarController()

    func start() {
        let homeVC = HomeViewController()
        homeVC.title = "Главная"
        homeVC.navigationItem.largeTitleDisplayMode = .always
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.navigationBar.prefersLargeTitles = true
        homeNav.tabBarItem = UITabBarItem(
            title: "Главная",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        let scheduleVC = ScheduleViewController()
        scheduleVC.title = "Расписание"
        scheduleVC.navigationItem.largeTitleDisplayMode = .always
        let scheduleNav = UINavigationController(rootViewController: scheduleVC)
        scheduleNav.navigationBar.prefersLargeTitles = true
        scheduleNav.tabBarItem = UITabBarItem(
            title: "Расписание",
            image: UIImage(systemName: "calendar"),
            selectedImage: UIImage(systemName: "calendar")
        )

        let tasksVC = TasksViewController()
        tasksVC.title = "Задания"
        tasksVC.navigationItem.largeTitleDisplayMode = .always
        let tasksNav = UINavigationController(rootViewController: tasksVC)
        tasksNav.navigationBar.prefersLargeTitles = true
        tasksNav.tabBarItem = UITabBarItem(
            title: "Задания",
            image: UIImage(systemName: "checklist"),
            selectedImage: UIImage(systemName: "checklist")
        )

        let mapVC = MapViewController()
        mapVC.title = "Карта"
        mapVC.navigationItem.largeTitleDisplayMode = .always
        let mapNav = UINavigationController(rootViewController: mapVC)
        mapNav.navigationBar.prefersLargeTitles = true
        mapNav.tabBarItem = UITabBarItem(
            title: "Карта",
            image: UIImage(systemName: "map"),
            selectedImage: UIImage(systemName: "map.fill")
        )

        let settingsVC = SettingsViewController()
        settingsVC.title = "Настройки"
        settingsVC.navigationItem.largeTitleDisplayMode = .always
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        settingsNav.navigationBar.prefersLargeTitles = true
        settingsNav.tabBarItem = UITabBarItem(
            title: "Настройки",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )

        tabBarController.viewControllers = [
            homeNav,
            scheduleNav,
            tasksNav,
            mapNav,
            settingsNav
        ]
    }
}
