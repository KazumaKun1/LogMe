//
//  FlexTextField.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/19/25.
//

import SwiftUI

struct FlexTextField: View {
    var placeholderText: String

    @Binding var text: String
    @Binding var isSecured: Bool

    init(placeholder: String,
         text: Binding<String>,
         isSecured: Binding<Bool> = .constant(false)) {
        placeholderText = placeholder
        _text = text
       _isSecured = isSecured
    }

    @State private var isTextVisible: Bool = false
    
    private let height: CGFloat = 22

    var body: some View {
        VStack {
            if isSecured {
                ZStack(alignment: .trailing) {
                    Group {
                        if isTextVisible {
                            TextField(text: $text) {
                                Text(placeholderText)
                                    .foregroundStyle(Color(UIColor.lightGray))
                            }
                            .frame(height: height)
                            .accessibilityLabel(placeholderText)
                            .accessibilityHint("Enter your secure \(placeholderText.lowercased())")
                            .accessibilityValue(text)
                            .textContentType(.password)
                        } else {
                            SecureField(text: $text) {
                                Text(placeholderText)
                                    .foregroundStyle(Color(UIColor.lightGray))
                            }
                            .frame(height: height)
                            .accessibilityLabel(placeholderText)
                            .accessibilityHint("Enter your secure \(placeholderText.lowercased())")
                            .accessibilityValue(text)
                            .textContentType(.password)
                        }
                    }
                    Button(action: { isTextVisible.toggle() }) {
                        Image(systemName: isTextVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .accessibilityLabel(isTextVisible ? "Hide password" : "Show password")
                    .padding(.trailing, 4)
                }
            } else {
                TextField(text: $text) {
                    Text(placeholderText)
                        .foregroundStyle(Color(UIColor.lightGray))
                }
                .frame(height: height)
                .accessibilityLabel(placeholderText)
                .accessibilityHint("Enter your \(placeholderText.lowercased())")
                .accessibilityValue(text)
                .textContentType(placeholderText.lowercased().contains("username") ? .username : .none)
            }
        }
        .padding(10)
        .foregroundStyle(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.white, lineWidth: 1)
        )
    }
}
