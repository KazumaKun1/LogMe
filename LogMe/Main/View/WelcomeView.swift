//
//  WelcomeView.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/18/25.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @Bindable var viewModel: LoginViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Text("Welcome! \(viewModel.user.username)")
                    .font(.adaptive(randomized: true, sizeClass: horizontalSizeClass, baseSize: 50, compactSize: 48))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .accessibilityAddTraits(.isHeader)
                Button {
                    viewModel.isWelcomePresented = false
                } label: {
                    Text("Sign out")
                        .padding(5)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .frame(maxWidth: 400)
                .accessibilityHint("Signs you out and returns to the login screen.")
            }
            .padding()
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Welcome screen")
        }
    }
}

#Preview {
    WelcomeView(viewModel: LoginViewModel(service: MockLoginService()))
}
