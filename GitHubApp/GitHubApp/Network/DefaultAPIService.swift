//
//  DefaultAPIService.swift
//  GitHubApp
//
//  Created by Ihor Ilin on 08.05.2025.
//

import Combine
import Foundation

final class DefaultAPIService: APIService {
    private let session = URLSession.shared
    
    func exchangeCodeForToken(code: String) -> AnyPublisher<TokenResponse, BackendError> {
        guard let url = URL(string: "https://backend-oauth.fly.dev/auth/github?code=\(code)") else {
            return Fail(error: BackendError(error: true, reason: "Fail to build URL!"))
                .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw BackendError(error: true, reason: "Invalid response")
                }
                
                if httpResponse.statusCode != 200 {
                    let error = try? JSONDecoder().decode(BackendError.self, from: data)
                    throw error ?? BackendError(error: true, reason: "Unknown error")
                }
                
                return data
            }.decode(type: TokenResponse.self, decoder: JSONDecoder())
            .mapError { error -> BackendError in
                if let backendError = error as? BackendError {
                    return backendError
                }
                
                return BackendError(error: true, reason: error.localizedDescription)
            }.eraseToAnyPublisher()
    }
}
