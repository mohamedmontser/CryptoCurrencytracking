//
//  BaseModel.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation


protocol BaseModel: Codable {
    func toJSON() -> [String: Any]?
}

extension BaseModel {
    func toJSON() -> [String: Any]? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(self)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return json
            } else {
                debugPrint("[toJSON-JSONSerialization] fails to convert data to json.")
                return nil
            }
        } catch {
            debugPrint("[toJSON-func]\(error)")
            return nil
        }
    }
    
}
