//
//  SettingsViewController.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 20.11.2023.
//

import UIKit

protocol SettingsViewControllerCoordinator: AnyObject {
    func didSelectCell(settiingsViewNavigation: SettingsViewNavigation)
}

class SettingsViewController: UITableViewController {
    
    private var viewModel: SettingsViewModel
    private weak var coordinator: SettingsViewControllerCoordinator?
    
    init(viewModel: SettingsViewModel, coordinator: SettingsViewControllerCoordinator?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Resources.Colors.backgroundGray
        title = "Settings"
        configureSettingsTable()
    }
    
    private func configureSettingsTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: .settingsTableViewCellIdentifier)
    }
}

// MARK: - TableView Delegates

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.settingsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModel.getItemSettingsViewModel(row: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: .settingsTableViewCellIdentifier,
                                                 for: indexPath)
        
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = viewModel.title
        contentConfiguration.image = UIImage(systemName: viewModel.icon)
        contentConfiguration.imageProperties.tintColor = Resources.Colors.backgroundGray
        cell.contentConfiguration = contentConfiguration
        cell.backgroundColor = Resources.Colors.MainModule.mainCollectionCellBackground
        if viewModel.isNotNavigatable {
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navigation = viewModel.cellSelected(row: indexPath.row)
        coordinator?.didSelectCell(settiingsViewNavigation: navigation)
    }
}

// MARK: - settingsTableViewCellIdentifier

extension String {
    static let settingsTableViewCellIdentifier = "settingsTableViewCellIdentifier"
}
