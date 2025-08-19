//
//  LoginService.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/19/25.
//

import Foundation

protocol LoginServiceProtocol {
    func login(user: User) throws
}

class LoginService: LoginServiceProtocol {
    func login(user: User) throws {
        guard let storedPassword = try KeychainManager.shared.getPassword(username: user.username) else {
            throw LoginError.invalidCredentials
        }
        guard storedPassword == user.password else {
            throw LoginError.invalidCredentials
        }
    }
}
