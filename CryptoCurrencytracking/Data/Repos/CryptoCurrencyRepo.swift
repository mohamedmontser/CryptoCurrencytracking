//
//  CryptoCurrencyRepo.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation
import Combine



final class CryptoCurrencyRepoImpl: CryptoCurrencyRepo {
    private let service: CryptoCurrencyService
    
    init(service: CryptoCurrencyService) {
        self.service = service
    }
}

extension CryptoCurrencyRepoImpl {
    
    func fetchAllCoins(request: CoinsRequestModel) -> AnyPublisher<[CoinsResponseModel], Error> {
        return service.fetchAllCoins(request: request)
    }
    
    func fetchCoinDetails(request: CoinDetailsRequestModel) -> AnyPublisher<CoinDetailsResponseModel, Error> {
        return service.fetchCoinDetails(request: request)
    }
}

