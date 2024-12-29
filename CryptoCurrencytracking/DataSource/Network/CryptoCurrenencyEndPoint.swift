//
//  CryptoCurrenencyEndPoint.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation
import Moya

enum CryptoCurrenencyAPI {
    case getAllCoins(_ params: CoinsRequestModel)
    case getCoinDetails(_ params: CoinDetailsRequestModel)
}

extension CryptoCurrenencyAPI: TargetType {
    var baseURL: URL { URL(string: Constants.baseURL.rawValue) ?? URL(fileURLWithPath: "") }
    
    var path: String {
        switch self {
        case .getAllCoins:
            return Constants.coins.rawValue
        case .getCoinDetails(let params):
            return Constants.coinDetails.rawValue + (params.id ?? "")
        }
    }
    
    var method: Moya.Method {
        return .get
    }
        
    var task: Task {
            switch self {
            case .getAllCoins(let params):
                return .requestParameters(parameters: params.toJSON() ?? [:], encoding: URLEncoding.default)
            case .getCoinDetails:
                return .requestPlain
            }
    }
    
    
    var headers: [String : String]? {
        return nil
    }
}

