//
//  MainCoordinator.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 11.12.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigation: UINavigationController
    private let factory: MainFactory
    
    init(navigation: UINavigationController, factory: MainFactory) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let viewController = factory.makeMainViewController(coordinator: self)
        factory.makeItemTabBar(navigation: navigation)
        navigation.pushViewController(viewController, animated: true)
    }
}

// MARK: - MainViewControllerCoordinator

extension MainCoordinator: MainViewControllerCoordinator {
    func didTapGenerateSettingsButton() {
        navigation.present(factory.makeGenerateViewController(), animated: true)
    }
}
