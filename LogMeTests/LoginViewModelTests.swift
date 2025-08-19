//
//  LoginViewModelTests.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/19/25.
//

import Testing
@testable import LogMe

struct LoginViewModelTests {
    private let delay: UInt64 = 0

    @Test
    func loginIsSuccessful() async {
        let sut = LoginViewModel(service: MockLoginService(), delay: delay)
        sut.user = User(username: "test", password: "password")
        await sut.login()
        
        #expect(sut.isWelcomePresented == true)
        #expect(sut.loginError == nil)
    }
    
    @Test
    func loginIsFailureDueToInvalidCredentials() async {
        let sut = LoginViewModel(service: MockLoginService(error: .invalidCredentials), delay: delay)
        sut.user = User(username: "wrong", password: "creds")
        await sut.login()
        
        #expect(sut.isWelcomePresented == false)
        #expect(sut.loginError == .invalidCredentials)
    }
    
    @Test
    func loginIsFailureDueToNetworkError() async {
        let sut = LoginViewModel(service: MockLoginService(error: .networkError), delay: delay)
        sut.user = User(username: "no", password: "internet")
        await sut.login()
        
        #expect(sut.isWelcomePresented == false)
        #expect(sut.loginError == .networkError)
    }
}
