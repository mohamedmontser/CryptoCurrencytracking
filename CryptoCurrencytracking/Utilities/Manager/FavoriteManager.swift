//
//  FavoriteManager.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 29/12/2024.
//

import Foundation


class FavoriteManager {
    
    private let favoritesKey = "favoriteCoins"
    private let userDefaults = UserDefaults.standard
    
    // Singleton instance
    static let shared = FavoriteManager()
    
    private init() {}
    
    /// Add a favorite object
    func addFavorite(_ coin: CoinsResponseModel) {
        var currentFavorites = getFavorites()
        guard !currentFavorites.contains(where: { $0.id == coin.id }) else { return } // Avoid duplicates
        currentFavorites.append(coin)
        saveFavorites(currentFavorites)
    }
    
    /// Remove a favorite object
    func removeFavorite(byID coinID: String) {
        var currentFavorites = getFavorites()
        currentFavorites.removeAll { $0.id == coinID }
        saveFavorites(currentFavorites)
    }
    
    /// Check if an object is marked as favorite
    func isFavorite(coinID: String) -> Bool {
        return getFavorites().contains(where: { $0.id == coinID })
    }
    
    /// Retrieve all favorite objects
    func getFavorites() -> [CoinsResponseModel] {
        guard let data = userDefaults.data(forKey: favoritesKey) else { return [] }
        do {
            return try JSONDecoder().decode([CoinsResponseModel].self, from: data)
        } catch {
            print("Failed to decode favorites: \(error)")
            return []
        }
    }
    
    /// Save the updated favorites to UserDefaults
    private func saveFavorites(_ favorites: [CoinsResponseModel]) {
        do {
            let data = try JSONEncoder().encode(favorites)
            userDefaults.set(data, forKey: favoritesKey)
        } catch {
            print("Failed to encode favorites: \(error)")
        }
    }
}
