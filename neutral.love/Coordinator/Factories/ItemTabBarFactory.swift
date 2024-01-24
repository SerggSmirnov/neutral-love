//
//  ItemTabBarFactory.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 09.12.2023.
//

import UIKit

protocol ItemTabBarFactory {}

extension ItemTabBarFactory {
    
    func makeItemTabBar(navigation: UINavigationController,
                        title: String,
                        image: UIImage,
                        tag: Int) {
        let tabBarItem = UITabBarItem(title: title,
                                      image: image,
                                      tag: tag)
        navigation.tabBarItem = tabBarItem
    }
}
