//
//  CryptoCurrencyRepo.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation
import Combine

protocol CryptoCurrencyRepo {
    func fetchAllCoins(request: CoinsRequestModel) -> AnyPublisher<[CoinsResponseModel], Error>
    func fetchCoinDetails(request: CoinDetailsRequestModel) -> AnyPublisher<CoinDetailsResponseModel, Error>
}
