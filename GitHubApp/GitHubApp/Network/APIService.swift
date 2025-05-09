//
//  APIService.swift
//  GitHubApp
//
//  Created by Ihor Ilin on 08.05.2025.
//

import Combine

protocol APIService {
    func exchangeCodeForToken(code: String) -> AnyPublisher<TokenResponse, BackendError>
}
