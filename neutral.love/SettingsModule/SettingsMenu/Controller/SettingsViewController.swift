//
//  SettingsViewController.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 20.11.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    private let viewModel: SettingsViewModel

    private let settingsView = SettingsView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        embedView()
        setupConstraints()
        setupDelegates()
    }

    // MARK: Init

    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupDelegates() {
        settingsView.settingsViewDelegate = self
    }
}

// MARK: - Setup View and Constraints
private extension SettingsViewController {
    func embedView() {
        view.addSubview(settingsView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            settingsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - SettingsViewDelegate

extension SettingsViewController: SettingsViewDelegate {
    func profileSettingsButtonPressed() {
        print("\(#function) pressed")
    }

    func themeSettingsButtonPressed() {
        print("\(#function) pressed")
    }

    func languageSettingsButtonPressed() {
        print("\(#function) pressed")
    }

    func projectLinkButtonPressed() {
        print("\(#function) pressed")
    }

    func firstContributorLinkButtonPressed() {
        print("\(#function) pressed")
    }

    func secondContributorLinkButtonPressed() {
        print("\(#function) pressed")
    }
}
