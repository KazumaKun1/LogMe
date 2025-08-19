//
//  LoginView.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/18/25.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel: LoginViewModel

    init(service: LoginServiceProtocol) {
        _viewModel = State(initialValue: LoginViewModel(service: service))
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            if viewModel.isWelcomePresented {
                WelcomeView(viewModel: viewModel)
                    .transition(.opacity)
            } else {
                VStack {
                    Spacer()
                    
                    // MARK: - Title
                    
                    Text("LogMe")
                        .font(.system(size: 58, weight: .bold))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.5), radius: 5)
                        .padding(.bottom, 40)
                        .accessibilityAddTraits(.isHeader)
                    
                    // MARK: - Login Section
                    
                    VStack {
                        VStack(spacing: 15) {
                            FlexTextField(placeholder: "Username", text: $viewModel.user.username)
                            FlexTextField(placeholder: "Password", text: $viewModel.user.password, isSecured: $viewModel.showPassword)
                        }
                        .padding(.bottom, 20)
                        
                        // MARK: - Login Button
                        
                        Button {
                            Task {
                                await viewModel.login()
                            }
                        } label: {
                            Text("Login")
                                .padding(5)
                                .frame(maxWidth: .infinity)
                        }
                        //.shadow(color: .black.opacity(0.3), radius: 5)
                        .buttonStyle(.borderedProminent)
                        .buttonBorderShape(.roundedRectangle)
                        .accessibilityHint("Attempts to log in with the entered credentials.")
                    }
                    .frame(maxWidth: 400)
                    .padding()
                    .accessibilityElement(children: .contain)
                    .accessibilityLabel("Login form")
                    Spacer()
                    
                    // MARK: - Sign up Button
                    
                    Button {
                        viewModel.isSignupPresented = true
                    } label: {
                        Text("Not a user? **Sign up here!**")
                            .foregroundStyle(.white)
                    }
                    .accessibilityHint("Opens the sign up form.")
                }
                .disabled(viewModel.isLoading)
            }
            
            if viewModel.isLoading {
                LoadingView()
                    .transition(.blurReplace)
            }
        }
        .animation(.easeInOut, value: viewModel.isWelcomePresented)
        .animation(.easeInOut, value: viewModel.isLoading)
        .centeredModal(isPresented: $viewModel.isSignupPresented) {
            SignUpView(parentViewModel: viewModel,
                       viewModel: SignUpViewModel(service: SignupService()))
        }
        .alert(isPresented: $viewModel.isLoginErrorPresented,
               error: viewModel.loginError) { }
    }
}

#Preview {
    LoginView(service: MockLoginService())
}
