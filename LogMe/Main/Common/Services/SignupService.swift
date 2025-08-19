//
//  SignupService.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/19/25.
//

protocol SignupServiceProtocol {
    func signup(user: User, confirmPassword: String) throws
}

class SignupService: SignupServiceProtocol {
    func signup(user: User, confirmPassword: String) throws {
        if user.username.isEmpty || user.password.isEmpty || confirmPassword.isEmpty {
            throw SignUpError.blankFields
        }

        if user.username.contains(" ") || user.password.contains(" ") || confirmPassword.contains(" ") {
            throw SignUpError.containsSpaces
        }

        if let _ = try KeychainManager.shared.getPassword(username: user.username) {
            throw SignUpError.userAlreadyExists
        }

        if user.password.count < 8 {
            throw SignUpError.invalidPassword
        }

        if user.password != confirmPassword {
            throw SignUpError.invalidConfirmPassword
        }

        try KeychainManager.shared.save(username: user.username, password: user.password)
    }
}
