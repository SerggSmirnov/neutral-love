//
//  SignInFactory.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 02.12.2023.
//

import UIKit

struct SignInFactory {
    let appDIContainer: AppDIContainer
    
    func makeSignInViewControler(coordinator: SignInViewControllerCoordinator) -> UIViewController {
        SignInViewController(viewModel: SignInViewModel(logInAuth: appDIContainer.auth),
                             coordinator: coordinator)
    }
}
