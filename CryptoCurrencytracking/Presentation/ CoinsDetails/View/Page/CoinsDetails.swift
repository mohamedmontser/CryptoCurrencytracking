//
//  CoinsDetails.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 29/12/2024.
//

import SwiftUI

struct CoinDetailsView: View {
    let coin: CoinsResponseModel
    
    var body: some View {
        VStack(spacing: 16) {
            // Coin Name
            Text(coin.name ?? "Unknown Coin")
                .font(.largeTitle)
                .bold()
            
            // Coin Symbol
            Text("Symbol: \(coin.symbol?.uppercased() ?? "N/A")")
                .font(.title2)
                .foregroundColor(.gray)
            
            // Coin Price
            if let price = coin.currentPrice {
                Text("Current Price: $\(price, specifier: "%.2f")")
                    .font(.title2)
            } else {
                Text("Current Price: N/A")
                    .font(.title2)
            }
            
            // 24h Percentage Change
            if let percentageChange = coin.priceChangePercentage24H {
                Text("24h Change: \(percentageChange, specifier: "%.2f")%")
                    .font(.title2)
                    .foregroundColor(percentageChange >= 0 ? .green : .red)
            } else {
                Text("24h Change: N/A")
                    .font(.title2)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Coin Details")
    }
}
