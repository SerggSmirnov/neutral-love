//
//  FavoritesFactory.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 10.12.2023.
//

import UIKit

protocol FavoritesFactory {
    func makeFavoritesViewController(coordinator: FavoritesViewControllerCoordinator) -> UIViewController
    func makeDetailViewController(viewModel: FavoritesViewModelProtocol) -> UIViewController
    func makeItemTabBar(navigation: UINavigationController)
}

struct FavoritesFactoryImp: FavoritesFactory {
    
    func makeFavoritesViewController(coordinator: FavoritesViewControllerCoordinator) -> UIViewController {
        let viewController = FavoritesAssembly.configure(coordinator: coordinator)
        viewController.title = Resources.Strings.TabBarModule.favorites
        return viewController
    }
    
    func makeDetailViewController(viewModel: FavoritesViewModelProtocol) -> UIViewController {
        DetailViewController(viewModel: viewModel)
    }
    
    func makeItemTabBar(navigation: UINavigationController) {
        makeItemTabBar(navigation: navigation,
                       title: Resources.Strings.TabBarModule.favorites,
                       image: Resources.Images.TabBarModule.favourites,
                       tag: 1)
    }
}

// MARK: - ItemTabBarFactory

extension FavoritesFactoryImp: ItemTabBarFactory {}
