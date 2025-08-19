//
//  LoginError.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/18/25.
//

import Foundation

enum LoginError: Error, LocalizedError {
    case invalidCredentials
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid username or password. Please try again."
        case .networkError:
            return "A network has occured. Please try again."
        }
    }
}
