//
//  LoginViewModel.swift
//  GitHubApp
//
//  Created by Ihor Ilin on 30.04.2025.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    private var oauthManager = OAuthManager()
    private var apiService = DefaultAPIService()
    private var cancelables = Set<AnyCancellable>()
    
    @Published var showAlert: Bool = false
    // Just show to the user in test purposes only!
    @Published var token: String?
    
    func login() {
        oauthManager.login()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // handle errors
            } receiveValue: { code in
                self.handleCode(code)
            }.store(in: &cancelables)
    }
    
    private func handleCode(_ code: String) {
        apiService.exchangeCodeForToken(code: code)
            .sink { completion in
                // handle errors
            } receiveValue: { token in
                self.token = token.access_token
                self.showAlert = true
                print("GitHubApp token = \(token)")
            }.store(in: &cancelables)

    }
}
