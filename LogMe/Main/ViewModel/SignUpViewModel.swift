//
//  SignUpViewModel.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/18/25.
//

import SwiftUI

@Observable
class SignUpViewModel {
    
    // MARK: - Properties
    
    var user = User(username: "", password: "")
    var confirmPassword = ""
    
    var isLoading = false
    
    var signUpError: SignUpError?
    var isSignUpErrorPresented: Bool {
        get { signUpError != nil }
        set { if !newValue { signUpError = nil } }
    }
    
    private var _isSignUpSuccessPresented = false
    var isSignUpSuccessPresented: Bool {
        get { _isSignUpSuccessPresented }
        set {
            _isSignUpSuccessPresented = newValue
            if newValue {
                user.username = ""
                user.password = ""
                confirmPassword = ""
            }
        }
    }
    
    @ObservationIgnored
    private var signupService: SignupServiceProtocol
    
    @ObservationIgnored
    private var timeDelayInNanoseconds: UInt64
    
    // MARK: - Init
    
    init(service: SignupServiceProtocol, delay: UInt64 = 1_000_000_000) {
        signupService = service
        timeDelayInNanoseconds = delay
    }
    
    // MARK: - Functions
    
    @MainActor
    func signUp() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await Task.sleep(nanoseconds: timeDelayInNanoseconds)
            try signupService.signup(user: user, confirmPassword: confirmPassword)
            isSignUpSuccessPresented = true
        } catch {
            isSignUpSuccessPresented = false
            signUpError = error as? SignUpError
        }
    }
}
