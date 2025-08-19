//
//  MockLoginService.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/19/25.
//

class MockLoginService: LoginServiceProtocol {
    private var loginError: LoginError?
    
    init(error: LoginError? = nil) {
        loginError = error
    }
    
    func login(user: User) throws {
        if let error = loginError {
            throw error
        }
    }
}
