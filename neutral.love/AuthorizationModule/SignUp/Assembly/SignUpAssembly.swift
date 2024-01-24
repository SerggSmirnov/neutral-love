//
//  SignUpAssembly.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 27.10.2023.
//

import Foundation

final class SignUpAssembly {
    static func configure() -> SignUpViewController {
        let viewModel = SignUpViewModel()
        let viewController = SignUpViewController(viewModel: viewModel)
        return viewController
    }
}
