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
    
    func login() {
        oauthManager.login()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print("UPS")
            } receiveValue: { code in
                self.handleCode(code)
            }.store(in: &cancelables)
    }
    
    private func handleCode(_ code: String) {
        apiService.exchangeCodeForToken(code: code)
            .sink { completion in
                print("UPS")
            } receiveValue: { token in
                print("GitHubApp token = \(token)")
            }.store(in: &cancelables)

    }
}
