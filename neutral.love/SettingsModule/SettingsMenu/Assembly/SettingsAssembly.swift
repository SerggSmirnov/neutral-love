//
//  SettingsAssembly.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 22.11.2023.
//

import Foundation

final class SettingsAssembly {
    static func configure() -> SettingsViewController {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel)
        return viewController
    }
}
