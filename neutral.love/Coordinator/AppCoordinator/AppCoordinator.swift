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
    var auth: Auth?
    
    init(navigation: UINavigationController, window: UIWindow?, factory: AppFactory?, auth: Auth?) {
        self.navigation = navigation
        self.window = window
        self.factory = factory
        self.auth = auth
    }
    
    func start() {
        print("start")
    }
}
