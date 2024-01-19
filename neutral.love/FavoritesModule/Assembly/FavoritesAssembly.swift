//
//  FavoritesAssembly.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 13.11.2023.
//

import Foundation

final class FavoritesAssembly {
    static func configure(coordinator: FavoritesViewControllerCoordinator) -> FavoritesViewController {
        let viewModel = FavoritesViewModel()
        let viewController = FavoritesViewController(viewModel: viewModel,
                                                     coordinator: coordinator)
        return viewController
    }
}
