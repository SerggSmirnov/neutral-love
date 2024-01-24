//
//  SettingsView.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 22.11.2023.
//

import UIKit

protocol SettingsViewDelegate: GeneralSettingsViewDelegate, AboutUsViewDelegate {
    func profileSettingsButtonPressed()
    func themeSettingsButtonPressed()
    func languageSettingsButtonPressed()
    
    func projectLinkButtonPressed()
    func firstContributorLinkButtonPressed()
    func secondContributorLinkButtonPressed()
}

final class SettingsView: UIView {

    // MARK: UI Elements
    
    private let portraitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.SettingsModule.personCircleFill
        imageView.tintColor = .systemGray4
        imageView.layer.cornerRadius = Constants.portraitImageViewDiameter / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.SettingsModule.usernameLabel
        label.font = Resources.Fonts.arialBold30
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let generalSettingsView = GeneralSettingsView()
    private let aboutUsView = AboutUsView()
    
    private let aboutUsLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Fonts.arial17
        label.textColor = .label
        label.text = Resources.Strings.SettingsModule.aboutUsLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Properties

    weak var settingsViewDelegate: SettingsViewDelegate? {
        didSet {
            generalSettingsView.delegate = settingsViewDelegate
            aboutUsView.delegate = settingsViewDelegate
        }
    }

    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        embedViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Appearence

extension SettingsView {
    private func setupAppearence() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Setup Constraints and View

private extension SettingsView {
    func embedViews() {
        [
            portraitImageView,
            usernameLabel,
            generalSettingsView,
            aboutUsView,
            aboutUsLabel
        ].forEach { addSubview($0) }
    }

    func setupConstraints() {
        setupPortraitImageViewConstraints()
        setupUserNameLabelConstraints()
        setupGeneralSettingsViewConstraints()
        setupAboutUsViewConstraints()
        setupAboutUsLabelConstraints()
    }

    func setupPortraitImageViewConstraints() {
        NSLayoutConstraint.activate([
            portraitImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            portraitImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            portraitImageView.heightAnchor.constraint(equalToConstant: Constants.portraitImageViewDiameter),
            portraitImageView.widthAnchor.constraint(equalToConstant: Constants.portraitImageViewDiameter)
        ])
    }
    
    func setupUserNameLabelConstraints() {
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: portraitImageView.bottomAnchor, constant: 10),
            usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func setupGeneralSettingsViewConstraints() {
        NSLayoutConstraint.activate([
            generalSettingsView.heightAnchor.constraint(equalToConstant: Constants.settingsViewHeight),
            generalSettingsView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 15),
            generalSettingsView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.settingsViewPadding),
            rightAnchor.constraint(equalTo: generalSettingsView.rightAnchor, constant: Constants.settingsViewPadding)
        ])
    }
    
    func setupAboutUsViewConstraints() {
        NSLayoutConstraint.activate([
            aboutUsView.heightAnchor.constraint(equalToConstant: Constants.settingsViewHeight),
            aboutUsView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.settingsViewPadding),
            rightAnchor.constraint(equalTo: aboutUsView.rightAnchor, constant: Constants.settingsViewPadding),
            aboutUsView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -35)
        ])
    }
    
    func setupAboutUsLabelConstraints() {
        NSLayoutConstraint.activate([
            aboutUsLabel.bottomAnchor.constraint(equalTo: aboutUsView.topAnchor, constant: -3),
            aboutUsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.aboutUsLabelLeftPadding)
        ])
    }
}

// MARK: - Setting Constants

extension SettingsView {
    private enum Constants {
        static let portraitImageViewDiameter: CGFloat = 180
        static let settingsViewPadding: CGFloat = 25
        static let settingsViewHeight: CGFloat = 120
        static let aboutUsLabelLeftPadding = Constants.settingsViewPadding + 5
    }
}
