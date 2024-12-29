//
//  CoinDetails.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation

struct CoinDetails: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let description: Description?
    let market_data: MarketData?
    let links: Links?
    
    struct Description: Codable {
        let en: String
    }
    
    struct MarketData: Codable {
        let current_price: [String: Double]?
        let market_cap: [String: Double]?
        let total_volume: [String: Double]?
        let price_change_percentage_24h: Double?
    }
    
    struct Links: Codable {
        let homepage: [String]?
        let blockchain_site: [String]?
    }
}
