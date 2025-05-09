//
//  OAuthManager.swift
//  GitHubApp
//
//  Created by Ihor Ilin on 08.05.2025.
//

import Combine
import AuthenticationServices

final class OAuthManager: NSObject, ObservableObject, ASWebAuthenticationPresentationContextProviding {
    enum AuthError: Error {
        case invalidCallback
    }
    
    var authSession: ASWebAuthenticationSession?
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        let scenes = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .filter { $0.isKeyWindow }
        
        return scenes.first ?? ASPresentationAnchor()
    }
    
    func login() -> AnyPublisher<String, Error> {
        Future<String, Error> { promise in
            let clientID = "Ov23lipHakDE5cMjLS9r"
            let oauthURL = URL(string: "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=user")!
            let schema = "githubapp"
            
            self.authSession = ASWebAuthenticationSession(url: oauthURL,
                                                          callbackURLScheme: schema,
                                                          completionHandler: { calbackURL, error in
                if let oauthError = error {
                    promise(.failure(oauthError))
                } else if let url = calbackURL,
                          let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems,
                          let code = queryItems.first(where: { $0.name == "code" })?.value {
                    promise(.success(code))
                } else {
                    promise(.failure(AuthError.invalidCallback))
                }
            })
            
            self.authSession?.presentationContextProvider = self
            self.authSession?.start()
            
        }.eraseToAnyPublisher()
    }
}
