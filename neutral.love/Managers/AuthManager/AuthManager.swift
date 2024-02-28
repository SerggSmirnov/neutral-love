//
//  AuthManager.swift
//  neutral.love
//
//  Created by Sergei Smirnov on 24.02.2024.
//

import Foundation
import FirebaseAuth

final class AuthManager  {
    
    func isUserLogin() -> Bool {
        Auth.auth().currentUser != nil
    }
}
