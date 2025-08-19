//
//  SignUpViewModelTests.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/19/25.
//

import Testing
@testable import LogMe

struct SignUpViewModelTests {
    private let delay: UInt64 = 0
    
    @Test
    func signUpIsSuccessful() async {
        let sut = SignUpViewModel(service: MockSignupService(), delay: delay)
        sut.user = User(username: "test", password: "correctPassword")
        sut.confirmPassword = "correctPassword"
        await sut.signUp()
        
        #expect(sut.isSignUpSuccessPresented == true)
        #expect(sut.signUpError == nil)
    }
    
    @Test
    func signUpIsFailureDueToBlankFields() async {
        let sut = SignUpViewModel(service: MockSignupService(error: .blankFields), delay: delay)
        sut.user = User(username: "", password: "")
        sut.confirmPassword = ""
        await sut.signUp()
        
        #expect(sut.isSignUpErrorPresented == true)
        #expect(sut.signUpError == .blankFields)
    }
    
    @Test
    func signUpIsFailureDueToUserAlreadyExist() async {
        let sut = SignUpViewModel(service: MockSignupService(error: .userAlreadyExists), delay: delay)
        sut.user = User(username: "existUser", password: "password")
        sut.confirmPassword = "password"
        await sut.signUp()
        
        #expect(sut.isSignUpErrorPresented == true)
        #expect(sut.signUpError == .userAlreadyExists)
    }
    
    @Test
    func signUpIsFailureDueToInvalidPassword() async {
        let sut = SignUpViewModel(service: MockSignupService(error: .invalidPassword), delay: delay)
        sut.user = User(username: "user", password: "invalidPassword")
        sut.confirmPassword = "password"
        await sut.signUp()
        
        #expect(sut.isSignUpErrorPresented == true)
        #expect(sut.signUpError == .invalidPassword)
    }
    
    @Test
    func signUpIsFailureDueToInvalidConfirmPassword() async {
        let sut = SignUpViewModel(service: MockSignupService(error: .invalidConfirmPassword), delay: delay)
        sut.user = User(username: "user", password: "invalidPassword")
        sut.confirmPassword = "password1"
        await sut.signUp()
        
        #expect(sut.isSignUpErrorPresented == true)
        #expect(sut.signUpError == .invalidConfirmPassword)
    }
    
    @Test
    func signUpIsFailureDueToContainsSpaces() async {
        let sut = SignUpViewModel(service: MockSignupService(error: .containsSpaces), delay: delay)
        sut.user = User(username: "user ", password: "inva ")
        sut.confirmPassword = "password1 "
        await sut.signUp()
        
        #expect(sut.isSignUpErrorPresented == true)
        #expect(sut.signUpError == .containsSpaces)
    }
    
    @Test
    func signUpIsFailureDueToRegistrationFailed() async {
        let sut = SignUpViewModel(service: MockSignupService(error: .registrationFailed), delay: delay)
        sut.user = User(username: "user", password: "validpassword")
        sut.confirmPassword = "validpassword"
        await sut.signUp()
        
        #expect(sut.isSignUpErrorPresented == true)
        #expect(sut.signUpError == .registrationFailed)
    }
}
