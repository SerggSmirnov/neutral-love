//
//  Coordinator.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 01.12.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigation: UINavigationController { get set }
    func start()
}
