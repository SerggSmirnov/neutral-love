//
//  TabBarAssembly.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 14.10.2023.
//

import UIKit

final class TabBarAssembly {
    static func configure() -> TabBarController {
        let tabBarController = TabBarController()
        tabBarController.viewControllers = []
        return tabBarController
    }
}
