//
//  CoinsDetailsRequestModel.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation


struct CoinsRequestModel: BaseModel {
    var vs_currency: String?
    var order: CoinsOrder?
    var per_page: Int?
    var page: Int?
}

enum CoinsOrder: String, Codable {
    case desc = "market_cap_desc"
    case asec = "market_cap_asec"
}
