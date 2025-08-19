//
//  MockSignupService.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/19/25.
//

class MockSignupService: SignupServiceProtocol {
    private var signUpError: SignUpError?
    
    init(error: SignUpError? = nil) {
        signUpError = error
    }

    func signup(user: User, confirmPassword: String) throws {
        if let error = signUpError {
            throw error
        }
    }
}
