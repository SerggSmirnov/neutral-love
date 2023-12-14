//
//  FavoritesCoordinator.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 10.12.2023.
//

import UIKit

final class FavoritesCoordinator: Coordinator {
    var navigation: UINavigationController
    private let factory: FavoritesFactory
    
    init(navigation: UINavigationController, factory: FavoritesFactory) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func start() {
        let viewController = factory.makeFavoritesViewController()
        factory.makeItemTabBar(navigation: navigation)
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(viewController, animated: true)
    }
}
