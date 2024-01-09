//
//  DetailAssembly.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 08.01.2024.
//

import UIKit

final class DetailAssembly {
    static func configure(viewModel: FavoritesViewModelProtocol) -> DetailViewController {
        DetailViewController(viewModel: viewModel)
    }
}
