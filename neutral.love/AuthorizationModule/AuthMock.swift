//
//  AuthMock.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 03.12.2023.
//

import Foundation

protocol SessionCheckerAuth {
    var isSessionActive: Bool { get }
}

protocol LogInAuth {
    func logIn()
}

protocol LogOutAuth {
    func logOut()
}

final class AuthMock {
    private var session = false
}

// MARK: - SessionCheckerAuth

extension AuthMock: SessionCheckerAuth {
    var isSessionActive: Bool {
        session
    }
}

// MARK: - LogInAuth

extension AuthMock: LogInAuth {
    func logIn() {
        session = true
    }
}

// MARK: - LogOutAuth

extension AuthMock: LogOutAuth {
    func logOut() {
        session = false
    }
}
