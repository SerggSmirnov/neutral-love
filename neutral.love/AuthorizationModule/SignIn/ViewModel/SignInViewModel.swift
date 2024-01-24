//
//  SignInViewModel.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 19.10.2023.
//

import Foundation

protocol SignInViewModelProtocol {
    var logInAuth: LogInAuth? { get set }
    func logIn()
}

final class SignInViewModel: SignInViewModelProtocol {
    
    var logInAuth: LogInAuth?

    // MARK: Init
    
    init(logInAuth: LogInAuth) {
        self.logInAuth = logInAuth
    }
    
    func logIn() {
        logInAuth?.logIn()
    }
}
