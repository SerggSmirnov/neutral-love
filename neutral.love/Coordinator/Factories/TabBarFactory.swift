//
//  TabBarFactory.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 04.12.2023.
//

import UIKit

struct TabBarFactory {
    let appDIContainer: AppDIContainer?
    
    func makeTabBarController() -> UITabBarController {
        TabBarAssembly.configure()
    }
    
    func makeChildCootdinators(delegate: SettingsCoordinatorDelegate) -> [Coordinator] {
        let favoritesCoordinator = makeFavoritesCoordinator()
        let mainCoordinator = makeMainCoordinator()
        let settingsCoordinator = makeSettingsCoordinator(delegate: delegate)
        return [favoritesCoordinator, mainCoordinator, settingsCoordinator]
    }
    
    private func makeFavoritesCoordinator() -> Coordinator {
        let factory = FavoritesFactoryImp()
        let navigation = UINavigationController()
        return FavoritesCoordinator(navigation: navigation,
                                    factory: factory)
    }
    
    private func makeMainCoordinator() -> Coordinator {
        let factory = MainFactoryImpl()
        let navigation = UINavigationController()
        return MainCoordinator(navigation: navigation,
                                    factory: factory)
    }

    private func makeSettingsCoordinator(delegate: SettingsCoordinatorDelegate) -> Coordinator {
        let factory = SettingsFactory(appDIContainer: appDIContainer)
        let navigation = UINavigationController()
        return SettingsCoordinator(navigation: navigation,
                                   factory: factory,
                                   delegate: delegate)
    }
}
