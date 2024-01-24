//
//  AppCoordinator.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 01.12.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigation: UINavigationController
    var window: UIWindow?
    var factory: AppFactory?
    var auth: SessionCheckerAuth?
    
    private var signInCoordinator: Coordinator?
    private var tabBarCoordinator: Coordinator?
    
    init(navigation: UINavigationController, 
         window: UIWindow?,
         factory: AppFactory?,
         auth: AuthMock?) {
        self.navigation = navigation
        self.window = window
        self.factory = factory
        self.auth = auth
    }
    
    func start() {
        setupWindow()
        startSomeCoordinator()
    }
    
    private func setupWindow() {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    private func startSomeCoordinator() {
        guard let auth else { return }
        
        auth.isSessionActive ? startTabBarCoordinator() : startSignInCoordinator()
    }
    
    private func startSignInCoordinator() {
        signInCoordinator = factory?.makeSignInCoordinator(navigation: navigation,
                                                           delegate: self)
        signInCoordinator?.start()
    }
    
    private func startTabBarCoordinator() {
        tabBarCoordinator = factory?.makeTabBarCoordinator(navigation: navigation,
                                                           delegate: self)
        tabBarCoordinator?.start()
    }
}

// MARK: - SignInCoordinatorDelegate

extension AppCoordinator: SignInCoordinatorDelegate {
    func didFinishLogin() {
        navigation.viewControllers = []
        signInCoordinator = nil
        startSomeCoordinator()
    }
}

// MARK: - TabBarCoordinatorDelegate

extension AppCoordinator: TabBarCoordinatorDelegate {
    func didFinish() {
        navigation.viewControllers = []
        signInCoordinator = nil
        tabBarCoordinator = nil
        startSomeCoordinator()
    }
}
