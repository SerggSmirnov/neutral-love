//
//  AppFactory.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 01.12.2023.
//

import UIKit

struct AppFactory {
    let appDIContainer: AppDIContainer
    
    func makeSignInCoordinator(navigation: UINavigationController, 
                               delegate: SignInCoordinatorDelegate) -> Coordinator {
        let signInFactory = SignInFactory(appDIContainer: appDIContainer)
        return SignInCoordinator(navigation: navigation,
                                            factory: signInFactory,
                                            delegate: delegate)
    }
    
    func makeTabBarCoordinator(navigation: UINavigationController,
                               delegate: TabBarCoordinatorDelegate?) -> Coordinator {
        let factory = TabBarFactory(appDIContainer: appDIContainer)
        return TabBarCoordinator(navigation: navigation, 
                                 factory: factory,
                                 delegate: delegate)
    }
}
