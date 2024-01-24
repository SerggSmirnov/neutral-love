//
//  SignInCoordinator.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 02.12.2023.
//

import UIKit

protocol SignInCoordinatorDelegate: AnyObject {
    func didFinishLogin()
}

final class SignInCoordinator: Coordinator {
    var navigation: UINavigationController
    var factory: SignInFactory
    weak var delegate: SignInCoordinatorDelegate?
    
    init(navigation: UINavigationController, factory: SignInFactory, delegate: SignInCoordinatorDelegate?) {
        self.navigation = navigation
        self.factory = factory
        self.delegate = delegate
    }
    
    func start() {
        let viewController = factory.makeSignInViewControler(coordinator: self)
        navigation.isNavigationBarHidden = true
        navigation.pushViewController(viewController, animated: true)
    }
}

// MARK: - SignInViewControllerCoordinator

extension SignInCoordinator: SignInViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinishLogin()
    }
}
