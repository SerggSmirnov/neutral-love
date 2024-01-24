//
//  SettingsCoordinator.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 09.12.2023.
//

import UIKit

protocol SettingsCoordinatorDelegate: AnyObject {
    func didTapLogOut()
}

final class SettingsCoordinator: Coordinator {
    var navigation: UINavigationController
    var factory: SettingsFactory
    weak var delegate: SettingsCoordinatorDelegate?
    
    init(navigation: UINavigationController,
         factory: SettingsFactory,
         delegate: SettingsCoordinatorDelegate?) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let settingsViewController = factory.makeSettingsViewController(coordinator: self)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(settingsViewController, animated: true)
        factory.makeItemTabBar(navigation: navigation)
    }
}

// MARK: - SettingsViewControllerCoordinator

extension SettingsCoordinator: SettingsViewControllerCoordinator {
    func didSelectCell(settiingsViewNavigation: SettingsViewNavigation) {
        switch settiingsViewNavigation {
        case .profileSettings:
            break
        case .theme:
            navigation.pushViewController(factory.makeThemeViewController(), animated: true)
        case .language:
            navigation.pushViewController(factory.makeLanguageViewController(), animated: true)
        case .logout:
            delegate?.didTapLogOut()
        case .noNavigation:
            break
        }
    }
}
