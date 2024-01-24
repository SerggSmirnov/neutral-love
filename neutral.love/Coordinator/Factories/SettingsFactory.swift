//
//  SettingsFactory.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 09.12.2023.
//

import UIKit

struct SettingsFactory: ItemTabBarFactory {
    let appDIContainer: AppDIContainer?
    
    func makeSettingsViewController(coordinator: SettingsViewControllerCoordinator) -> UIViewController {
        let viewModel = SettingsViewModel(auth: appDIContainer?.auth)
        let viewController = SettingsViewController(viewModel: viewModel,
                                                    coordinator: coordinator)
        viewController.title = Resources.Strings.TabBarModule.settings
        return viewController
    }
    
    func makeItemTabBar(navigation: UINavigationController) {
        makeItemTabBar(navigation: navigation,
                       title: Resources.Strings.TabBarModule.settings,
                       image: Resources.Images.TabBarModule.settings, 
                       tag: 3)
    }
    
    func makeThemeViewController() -> UIViewController {
        let viewController = ThemeViewController()
        viewController.title = "Theme"
        return viewController
    }
    
    func makeLanguageViewController() -> UIViewController {
        let viewController = LanguageViewController()
        viewController.title = "Language"
        return viewController
    }
}
