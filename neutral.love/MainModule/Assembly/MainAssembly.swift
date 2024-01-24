//
//  MainAssembly.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 16.10.2023.
//

import UIKit

final class MainAssembly {
    static func configure(coordinator: MainViewControllerCoordinator, 
                          viewModel: MainViewModelProtocol) -> MainViewController {
        
        let viewController = MainViewController(viewModel: viewModel, 
                                                coordinator: coordinator)
        return viewController
    }
}
