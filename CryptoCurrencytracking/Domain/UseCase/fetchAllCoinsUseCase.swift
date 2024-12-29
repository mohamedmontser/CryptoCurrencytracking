//
//  UseCase.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation
import Combine

protocol FetchAllCoinsUseCaseP {
    var repository: CryptoCurrencyRepo {get}
    func execute(request: CoinsRequestModel) -> AnyPublisher<[CoinsResponseModel], Error>
}

struct FetchAllCoinsUseCase: FetchAllCoinsUseCaseP {
  
    internal let repository: CryptoCurrencyRepo
    
    init(repository: CryptoCurrencyRepo) {
        self.repository = repository
    }
    
    func execute(request: CoinsRequestModel) -> AnyPublisher<[CoinsResponseModel], Error> {
        return repository.fetchAllCoins(request: request)
    }
}
