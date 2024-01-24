//
//  TabBarCoordinator.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 04.12.2023.
//

import UIKit

protocol TabBarCoordinatorDelegate: AnyObject {
    func didFinish()
}

final class TabBarCoordinator: Coordinator {
    var navigation: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let factory: TabBarFactory
    private weak var delegate: TabBarCoordinatorDelegate?
    
    init(navigation: UINavigationController, 
         factory: TabBarFactory,
         delegate: TabBarCoordinatorDelegate?) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let navigationTabBar = factory.makeTabBarController()
        navigation.pushViewController(navigationTabBar, animated: false)
        navigation.navigationBar.isHidden = true
        
        childCoordinators = factory.makeChildCootdinators(delegate: self)
        
        let childNavigation = childCoordinators.map { $0.navigation }
        childCoordinators.forEach { $0.start() }
        navigationTabBar.viewControllers = childNavigation
        navigationTabBar.selectedIndex = Constants.selectedMainModule
    }
}

// MARK: - SettingsCoordinatorDelegate

extension TabBarCoordinator: SettingsCoordinatorDelegate {
    func didTapLogOut() {
        childCoordinators = []
        delegate?.didFinish()
    }
}

// MARK: - Constants

extension TabBarCoordinator {
     private enum Constants {
        static let selectedMainModule: Int = 1
    }
}
