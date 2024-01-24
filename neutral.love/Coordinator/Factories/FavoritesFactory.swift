//
//  FavoritesFactory.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 10.12.2023.
//

import UIKit

protocol FavoritesFactory {
    var viewModel: FavoritesViewModelProtocol { get set }
    
    func makeFavoritesViewController(coordinator: FavoritesViewControllerCoordinator) -> UIViewController
    func makeDetailViewController(coordinator: DetailViewControllerCoordinator) -> UIViewController
    func makeItemTabBar(navigation: UINavigationController)
}

struct FavoritesFactoryImp: FavoritesFactory {
    var viewModel: FavoritesViewModelProtocol = FavoritesViewModel()
    
    func makeFavoritesViewController(coordinator: FavoritesViewControllerCoordinator) -> UIViewController {
        let viewController = FavoritesAssembly.configure(coordinator: coordinator, viewModel: viewModel)
        viewController.title = Resources.Strings.TabBarModule.favorites
        return viewController
    }
    
    func makeDetailViewController(coordinator: DetailViewControllerCoordinator) -> UIViewController {
        DetailViewController(viewModel: viewModel, coordinator: coordinator)
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
