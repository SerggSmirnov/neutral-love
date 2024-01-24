//
//  AboutUsView.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 27.11.2023.
//

import UIKit

protocol AboutUsViewDelegate: AnyObject {
    func projectLinkButtonPressed()
    func firstContributorLinkButtonPressed()
    func secondContributorLinkButtonPressed()
}

final class AboutUsView: UIView {

    // MARK: UI Elements

    private let firstDividerView = DividerView()
    private let secondDividerView = DividerView()

    private let projectLinkView1 = UIView()
    private let projectLinkView2 = UIView()
    private let projectLinkView3 = UIView()

    private let viewsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let profileLinkButton = UIButton()
    private let firstContributorLinkButton = UIButton()
    private let secondContributorLinkButton = UIButton()

    // MARK: Properties

    weak var delegate: AboutUsViewDelegate?

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewsStackView()
        setupProjectLinkButton()
        setupFirstContributorLinkButton()
        setupSecondContributorLinkButton()

        setupAppearence()
        embedViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    private func setupViewsStackView() {
        viewsStackView.addArrangedSubview(projectLinkView1)
        viewsStackView.addArrangedSubview(projectLinkView2)
        viewsStackView.addArrangedSubview(projectLinkView3)
    }

    private func setupProjectLinkButton() {
        profileLinkButton.setTitle(Resources.Strings.SettingsModule.profileSettingsButtonTitle, for: .normal)
        profileLinkButton.titleLabel?.font = Resources.Fonts.arial17
        profileLinkButton.setTitleColor(Resources.Colors.SettingsModule.buttonsLabelColor, for: .normal)
        profileLinkButton.contentHorizontalAlignment = .left
        profileLinkButton.addTarget(self, action: #selector(projectLinkButtonPressed), for: .touchUpInside)
        profileLinkButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupFirstContributorLinkButton() {
        firstContributorLinkButton.setTitle(Resources.Strings.SettingsModule.firstContributorButtonTitle, for: .normal)
        firstContributorLinkButton.titleLabel?.font = Resources.Fonts.arial17
        firstContributorLinkButton.setTitleColor(Resources.Colors.SettingsModule.buttonsLabelColor, for: .normal)
        firstContributorLinkButton.contentHorizontalAlignment = .left
        firstContributorLinkButton.addTarget(self, action: #selector(firstContributorLinkButtonPressed), for: .touchUpInside)
        firstContributorLinkButton.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupSecondContributorLinkButton() {
        secondContributorLinkButton.setTitle(Resources.Strings.SettingsModule.secondContributorButtonTitle, for: .normal)
        secondContributorLinkButton.titleLabel?.font = Resources.Fonts.arial17
        secondContributorLinkButton.setTitleColor(Resources.Colors.SettingsModule.buttonsLabelColor, for: .normal)
        secondContributorLinkButton.contentHorizontalAlignment = .left
        secondContributorLinkButton.addTarget(self, action: #selector(secondContributorLinkButtonPressed), for: .touchUpInside)
        secondContributorLinkButton.translatesAutoresizingMaskIntoConstraints = false
    }

    @objc
    private func projectLinkButtonPressed() {
        delegate?.projectLinkButtonPressed()
    }

    @objc
    private func firstContributorLinkButtonPressed() {
        delegate?.firstContributorLinkButtonPressed()
    }

    @objc
    private func secondContributorLinkButtonPressed() {
        delegate?.secondContributorLinkButtonPressed()
    }
}

// MARK: - Setup Appearence

extension AboutUsView {
    private func setupAppearence() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Setup Constraints and View

private extension AboutUsView {
    func embedViews() {
        [
            viewsStackView,
            firstDividerView,
            secondDividerView
        ].forEach { addSubview($0) }

        projectLinkView1.addSubview(profileLinkButton)
        projectLinkView2.addSubview(firstContributorLinkButton)
        projectLinkView3.addSubview(secondContributorLinkButton)
    }

    func setupConstraints() {
        setupDividersConstraints()
        setupDividersStackViewConstraints()
        setupProfileSettingsButtonConstraints()
        setupFirstContributorButtonConstraints()
        setupSecondContributorButtonConstraints()
    }

    func setupDividersConstraints() {
        NSLayoutConstraint.activate([
            firstDividerView.topAnchor.constraint(equalTo: projectLinkView1.bottomAnchor),
            firstDividerView.leftAnchor.constraint(equalTo: leftAnchor),
            firstDividerView.rightAnchor.constraint(equalTo: rightAnchor),
            firstDividerView.bottomAnchor.constraint(equalTo: projectLinkView2.topAnchor),

            secondDividerView.topAnchor.constraint(equalTo: projectLinkView2.bottomAnchor),
            secondDividerView.leftAnchor.constraint(equalTo: leftAnchor),
            secondDividerView.rightAnchor.constraint(equalTo: rightAnchor),
            secondDividerView.bottomAnchor.constraint(equalTo: projectLinkView3.topAnchor)
        ])
    }

    func setupDividersStackViewConstraints() {
        NSLayoutConstraint.activate([
            viewsStackView.topAnchor.constraint(equalTo: topAnchor),
            viewsStackView.leftAnchor.constraint(equalTo: leftAnchor),
            viewsStackView.rightAnchor.constraint(equalTo: rightAnchor),
            viewsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupProfileSettingsButtonConstraints() {
        NSLayoutConstraint.activate([
            profileLinkButton.centerYAnchor.constraint(equalTo: projectLinkView1.centerYAnchor),
            profileLinkButton.leftAnchor.constraint(equalTo: projectLinkView1.leftAnchor, constant: Constants.buttonsLeftPadding),
            profileLinkButton.rightAnchor.constraint(equalTo: projectLinkView1.rightAnchor)
        ])
    }

    func setupFirstContributorButtonConstraints() {
        NSLayoutConstraint.activate([
            firstContributorLinkButton.centerYAnchor.constraint(equalTo: projectLinkView2.centerYAnchor),
            firstContributorLinkButton.leftAnchor.constraint(equalTo: projectLinkView2.leftAnchor, constant: Constants.buttonsLeftPadding),
            firstContributorLinkButton.rightAnchor.constraint(equalTo: projectLinkView2.rightAnchor)
        ])
    }

    func setupSecondContributorButtonConstraints() {
        NSLayoutConstraint.activate([
            secondContributorLinkButton.centerYAnchor.constraint(equalTo: projectLinkView3.centerYAnchor),
            secondContributorLinkButton.leftAnchor.constraint(equalTo: projectLinkView3.leftAnchor, constant: Constants.buttonsLeftPadding),
            secondContributorLinkButton.rightAnchor.constraint(equalTo: projectLinkView3.rightAnchor)
        ])
    }
}

// MARK: - Constants

extension AboutUsView {
    private enum Constants {
        static let buttonsLeftPadding: CGFloat = 20
    }
}
