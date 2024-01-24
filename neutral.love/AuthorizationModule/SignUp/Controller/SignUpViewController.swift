//
//  SignUpViewController.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 27.10.2023.
//

import UIKit

final class SignUpViewController: UIViewController {
    private let signUpView = SignUpView()
    private let viewModel: SignUpViewModelProtocol

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        embedViews()
        setupConstraints()
    }

    // MARK: Init

    init(viewModel: SignUpViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Methods

    private func setupDelegate() {
        signUpView.delegate = self
    }
}

// MARK: - Setup UI elements and constraints

private extension SignUpViewController {
    func embedViews() {
        view.addSubview(signUpView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            signUpView.topAnchor.constraint(equalTo: view.topAnchor),
            signUpView.leftAnchor.constraint(equalTo: view.leftAnchor),
            signUpView.rightAnchor.constraint(equalTo: view.rightAnchor),
            signUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - SignUpViewDelegate

extension SignUpViewController: SignUpViewDelegate {
    func signUpButtonPressed() {}

    func backButtonPressed() {
        self.dismiss(animated: true)
    }
}
