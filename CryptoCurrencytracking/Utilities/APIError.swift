//
//  Enum.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation

enum APIError: LocalizedError {
    case networkError(String)
    case decodingError(String)
    case responseError(String)
    
    var errorDescription: String? {
        switch self {
        case .networkError(let message):
            return "Network Error: \(message)"
        case .decodingError(let message):
            return "Decoding Error: \(message)"
        case .responseError(let message):
            return "Server Error: \(message)"
        }
    }
}
