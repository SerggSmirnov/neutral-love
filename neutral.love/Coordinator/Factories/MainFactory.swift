//
//  MainFactory.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 11.12.2023.
//

import UIKit

protocol MainFactory {
    func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController
    func makeGenerateViewController() -> UIViewController
    func makeItemTabBar(navigation: UINavigationController)
}

struct MainFactoryImpl: MainFactory {
    private let viewModel = MainViewModel()
    
    func makeMainViewController(coordinator: MainViewControllerCoordinator) -> UIViewController {
        MainAssembly.configure(coordinator: coordinator, viewModel: viewModel)
    }
    
    func makeGenerateViewController() -> UIViewController {
        GenerateAssembly.configure(viewModel: viewModel)
    }
    
    func makeItemTabBar(navigation: UINavigationController) {
        makeItemTabBar(navigation: navigation,
                       title: Resources.Strings.TabBarModule.main,
                       image: Resources.Images.TabBarModule.main,
                       tag: 2)
    }
}

// MARK: - ItemTabBarFactory

extension MainFactoryImpl: ItemTabBarFactory {}
