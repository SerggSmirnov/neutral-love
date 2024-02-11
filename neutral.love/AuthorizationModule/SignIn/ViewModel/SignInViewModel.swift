//
//  SignInViewModel.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 19.10.2023.
//

import Foundation
import FirebaseAuth

protocol SignInViewModelProtocol {
    var auth: AuthMock? { get set }
}

final class SignInViewModel: SignInViewModelProtocol {
    
    var auth: AuthMock?

    // MARK: Init
    
    init(auth: AuthMock) {
        self.auth = auth
    }
}
