//
//  BackendError.swift
//  GitHubApp
//
//  Created by Ihor Ilin on 08.05.2025.
//

import Foundation

struct BackendError: Codable, Error {
    let error: Bool
    let reason: String
}
