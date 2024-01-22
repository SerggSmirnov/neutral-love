//
//  DetailAssembly.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 08.01.2024.
//

import UIKit

final class DetailAssembly {
    static func configure(viewModel: FavoritesViewModelProtocol,
                          coordinator: DetailViewControllerCoordinator) -> DetailViewController {
        DetailViewController(viewModel: viewModel, 
                             coordinator: coordinator)
    }
}
