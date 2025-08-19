//
//  LogMeApp.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/18/25.
//

import SwiftUI

@main
struct LogMeApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(service: LoginService())
        }
    }
}
