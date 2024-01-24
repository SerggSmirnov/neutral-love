//
//  SignInViewController.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 21.10.2023.
//

import UIKit

protocol SignInViewControllerCoordinator: AnyObject {
    func didFinish()
}

final class SignInViewController: UIViewController {
    private let signInView = SignInView()
    private let viewModel: SignInViewModelProtocol
    private weak var coordinator: SignInViewControllerCoordinator?

    init(viewModel: SignInViewModelProtocol, 
         coordinator: SignInViewControllerCoordinator?) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedView()
        setupConstraints()
        setupDelegate()
    }

    private func setupDelegate() {
        signInView.delegate = self
    }
}

// MARK: - Setup View and Constraints

private extension SignInViewController {
    func embedView() {
        view.addSubview(signInView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            signInView.topAnchor.constraint(equalTo: view.topAnchor),
            signInView.leftAnchor.constraint(equalTo: view.leftAnchor),
            signInView.rightAnchor.constraint(equalTo: view.rightAnchor),
            signInView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - SignInViewDelegate

extension SignInViewController: SignInViewDelegate {
    func signUpButtonPressed() {}
    
    func signInButtonPressed() {
        viewModel.logIn()
        coordinator?.didFinish()
    }
}
