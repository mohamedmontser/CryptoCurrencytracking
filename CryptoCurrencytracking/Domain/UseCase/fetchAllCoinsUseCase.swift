//
//  UseCase.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation
import Combine

protocol fetchAllCoinsUseCaseP {
    var repository: CryptoCurrencyRepo {get set}
    func execute(request: CoinsRequestModel) -> AnyPublisher<[CoinsResponseModel], Error>
}

struct fetchAllCoinsUseCase {
    private let repository: CryptoCurrencyRepo
    
    init(repository: CryptoCurrencyRepo) {
        self.repository = repository
    }
    
    func execute(request: CoinsRequestModel) -> AnyPublisher<[CoinsResponseModel], Error> {
        return repository.fetchAllCoins(request: request)
    }
}

struct FetchGiveawaysByPlatformUseCase {
    private let repository: GiveawayRepo
    
    init(repository: GiveawayRepo) {
        self.repository = repository
    }
    
    func execute(platform: String) -> AnyPublisher<[Giveaway], Error> {
        return repository.fetchGiveawaysByPlatform(platform: platform)
    }
}
