//
//  SignUpError.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/18/25.
//

import Foundation

enum SignUpError: Error, LocalizedError {
    case blankFields
    case userAlreadyExists
    case invalidPassword
    case invalidConfirmPassword
    case containsSpaces
    case registrationFailed
    
    var errorDescription: String? {
        switch self {
        case .blankFields:
            return "All fields are required."
        case .userAlreadyExists:
            return "User already exists."
        case .invalidPassword:
            return "Password must be at least 8 characters long"
        case .invalidConfirmPassword:
            return "Passwords do not match"
        case .containsSpaces:
            return "Username or password cannot contain spaces."
        case .registrationFailed:
            return "Registration failed. Please try again later."
        }
    }
}
