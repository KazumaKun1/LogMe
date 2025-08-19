//
//  SignUpView.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/18/25.
//

import SwiftUI

struct SignUpView: View {
    @Bindable var parentViewModel: LoginViewModel
    @State var viewModel: SignUpViewModel
    
    var body: some View {
        ZStack {
            BackgroundView(enableAnimation: false)
            VStack(alignment: .leading) {
                // MARK: - Title
                
                Text("Create an account")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .bold()
                    .padding(.bottom, 30)
                    .accessibilityAddTraits(.isHeader)
                
                // MARK: - Username Section
                
                VStack(alignment: .leading) {
                    Text("Enter your username")
                        .foregroundStyle(.white)
                        .accessibilityLabel("Username section")
                    FlexTextField(placeholder: "Username", text: $viewModel.user.username)
                }
                .padding(.bottom, 20)
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Username input group")
                
                // MARK: - Password Section
                
                VStack(alignment: .leading) {
                    Text("Enter your password")
                        .foregroundStyle(.white)
                        .accessibilityLabel("Password section")
                    FlexTextField(placeholder: "Password (Min. 8 characters)", text: $viewModel.user.password, isSecured: .constant(true))
                        .padding(.bottom, 5)
                    FlexTextField(placeholder: "Confirm Password", text: $viewModel.confirmPassword, isSecured: .constant(true))
                }
                .accessibilityElement(children: .contain)
                .accessibilityLabel("Password input group")
                Spacer()
                
                // MARK: - Sign up Button
                
                Button {
                    Task {
                        await viewModel.signUp()
                    }
                } label: {
                    Text("Sign up")
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .shadow(color: .black.opacity(0.3), radius: 5)
                .accessibilityHint("Creates your account with the entered information.")
            }
            .padding()
            .disabled(viewModel.isLoading)
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(isPresented: $viewModel.isSignUpSuccessPresented) {
            Alert(title: Text("Signup Successful! You may login now."), dismissButton: .default(Text("Ok")) {
                parentViewModel.isSignupPresented = false
            })
        }
        .alert(isPresented: $viewModel.isSignUpErrorPresented,
               error: viewModel.signUpError) { }
    }
}

#Preview {
    SignUpView(
        parentViewModel: LoginViewModel(service: MockLoginService()),
        viewModel: .init(service: MockSignupService())
    )
}
