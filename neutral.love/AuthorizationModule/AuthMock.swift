//
//  AuthMock.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 03.12.2023.
//

import Foundation
import FirebaseAuth

protocol SessionCheckerAuth {
    var isSessionActive: Bool { get }
    
    func isUserLogin()
}

protocol LogInAuth {
    func logIn(withEmail email: String, password: String)
}

protocol LogOutAuth {
    func logOut()
}

protocol SignUpAuth {
    func createUser(withEmail email: String, password: String)
}

final class AuthMock {
    private var session = false
}

// MARK: - SessionCheckerAuth

extension AuthMock: SessionCheckerAuth {
    var isSessionActive: Bool {
        session
    }
    
    func isUserLogin() {
        if Auth.auth().currentUser != nil {
            session = true
        } else {
            session = false
        }
    }
}

// MARK: - LogInAuth

extension AuthMock: LogInAuth {
    func logIn(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            
            if let error = error {
                let textError = "Sign-in error: \(error.localizedDescription)"
                print(textError)
            } else {
                self?.session = true
            }
        }
    }
}

// MARK: - LogOutAuth

extension AuthMock: LogOutAuth {
    func logOut() {
        do {
            try Auth.auth().signOut()
            self.session = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

// MARK: - SignUpAuth

extension AuthMock: SignUpAuth {
    func createUser(withEmail email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            
            if let error = error {
                let textError = "Create user error: \(error.localizedDescription)"
                print(textError)
            } else {
                self?.session = true
            }
        }
    }
}
