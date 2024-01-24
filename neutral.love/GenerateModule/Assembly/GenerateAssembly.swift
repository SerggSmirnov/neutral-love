//
//  GenerateAssembly.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 21.10.2023.
//

import UIKit

final class GenerateAssembly {
    static func configure(viewModel: MainViewModelProtocol) -> GenerateViewController {
        let viewController = GenerateViewController(viewModel: viewModel)
        return viewController
    }
}
