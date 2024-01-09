//
//  SceneDelegate.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 05.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: Coordinator?
    var appFactory: AppFactory?
    var appDIContainer: AppDIContainer?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        appDIContainer = AppDIContainer()
        guard let appDIContainer else { return }
        
        appFactory = AppFactory(appDIContainer: appDIContainer)
        appCoordinator = AppCoordinator(navigation: UINavigationController(),
                                        window: window,
                                        factory: appFactory,
                                        auth: appDIContainer.auth)
        appCoordinator?.start()
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        window = UIWindow(windowScene: windowScene)
//        window?.rootViewController = DetailViewController(viewModel: FavoritesViewModel())
//        window?.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.shared.saveContext()
    }
}
