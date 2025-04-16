//
//  AppRouter.swift
//  GitHubApp
//
//  Created by Ihor Ilin on 16.04.2025.
//

import Foundation
import SwiftUI

enum AppRoute {
    case login
    case repositories
    case profile
    case search
    case settings
}

struct AppRouter: View {
    
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        if isLoggedIn {
            MainTabView()
        } else {
            LoginView()
        }
        
    }
}
