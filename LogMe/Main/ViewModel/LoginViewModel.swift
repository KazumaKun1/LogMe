//
//  LoginViewModel.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/18/25.
//

import SwiftUI

@Observable
class LoginViewModel {
    
    // MARK: - Properties
    
    var user = User(username: "", password: "")
    var isLoading = false
    var showPassword = true
    
    var isSignupPresented = false
    
    private var _isWelcomePresented = false
    var isWelcomePresented: Bool {
        get { _isWelcomePresented }
        set {
            _isWelcomePresented = newValue
            if !newValue {
                user.username = ""
                user.password = ""
            }
        }
    }
    
    var loginError: LoginError?
    var isLoginErrorPresented: Bool {
        get { loginError != nil }
        set { if !newValue { loginError = nil } }
    }
    
    @ObservationIgnored
    private var loginService: LoginServiceProtocol
    
    @ObservationIgnored
    private var timeDelayInNanoseconds: UInt64
    
    // MARK: - Init
    
    init(service: LoginServiceProtocol, delay: UInt64 = 1_000_000_000) {
        loginService = service
        timeDelayInNanoseconds = delay
    }
    
    // MARK: - Functions
    
    @MainActor
    func login() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            try await Task.sleep(nanoseconds: timeDelayInNanoseconds)
            try loginService.login(user: user)
            isWelcomePresented = true
        } catch {
            isWelcomePresented = false
            loginError = error as? LoginError
        }
    }
}
