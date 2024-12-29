//
//  CryptoCurrencyService.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation
import Moya
import Combine

class CryptoCurrencyService {
  
    private let provider = MoyaProvider<CryptoCurrenencyAPI>()
    var cancellables = Set<AnyCancellable>()
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetchAllCoins(request: CoinsRequestModel) -> AnyPublisher<[CoinsResponseModel], Error> {
        return Future { promise in
            let target = CryptoCurrenencyAPI.getAllCoins(request)
           
            if let request = try? self.provider.endpoint(target).urlRequest() {
                print("Request URL: \(request.url?.absoluteString ?? "N/A")")
                print("Request Headers: \(request.allHTTPHeaderFields ?? [:])")
                if let body = request.httpBody {
                    print("Request Body: \(String(data: body, encoding: .utf8) ?? "N/A")")
                }
            }

            self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    print("Response Status Code: \(response.statusCode)")
                    print("Response Data: \(String(data: response.data, encoding: .utf8) ?? "N/A")")

                    do {
                        if (200...299).contains(response.statusCode) {
                            let coins = try JSONDecoder().decode([CoinsResponseModel].self, from: response.data)
                            promise(.success(coins))
                        } else {
                            promise(.failure(APIError.responseError("Failed to fetch coins: \(response.statusCode)")))
                        }
                    } catch {
                        promise(.failure(APIError.decodingError(error.localizedDescription)))
                    }
                case .failure(let error):
                    print("Request Failed with Error: \(error.localizedDescription)")
                    promise(.failure(APIError.networkError(error.localizedDescription)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
//    func fetchAllCoins(request: CoinsRequestModel) -> AnyPublisher<[CoinsResponseModel], Error> {
//        // Construct the full URL
//        guard let url = URL(string:  "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=30&page=1") else {
//            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
//        }
//        
//        // Create a URL request
//        let urlRequest = URLRequest(url: url)
//        
//        // Perform the network request using Combine
//        return urlSession.dataTaskPublisher(for: urlRequest)
//            .map(\.data) // Extract the data from the response
//            .decode(type: [CoinsResponseModel].self, decoder: JSONDecoder()) // Decode JSON into the response model
//            .receive(on: DispatchQueue.main) // Ensure updates happen on the main thread
//            .eraseToAnyPublisher() // Return an `AnyPublisher`
//    }

    
    func fetchCoinDetails(request: CoinDetailsRequestModel) -> AnyPublisher<CoinDetailsResponseModel, Error> {
        
        let target = CryptoCurrenencyAPI.getCoinDetails(request)
        return Future { promise in
            self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        if (200...299).contains(response.statusCode) {
                            let details = try JSONDecoder().decode(CoinDetailsResponseModel.self, from: response.data)
                            promise(.success(details))
                        } else {
                            promise(.failure(APIError.responseError("Failed to fetch coin details: \(response.statusCode)")))
                        }
                    } catch {
                        promise(.failure(APIError.decodingError(error.localizedDescription)))
                    }
                case .failure(let error):
                    promise(.failure(APIError.networkError(error.localizedDescription)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}



