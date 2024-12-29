//
//  AppState.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 29/12/2024.
//

import Foundation

enum AppState {
    case loading
    case success
    case error(String)
    case emptyData
    case searchEmptyResult(String)
    case getMoreData
   
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
             (.success, .success),
             (.emptyData, .emptyData),
             (.getMoreData, .getMoreData):
            return true
        case let (.error(lhsMessage), .error(rhsMessage)):
            return lhsMessage == rhsMessage
        case let (.searchEmptyResult(lhsMessage), .searchEmptyResult(rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }

}
