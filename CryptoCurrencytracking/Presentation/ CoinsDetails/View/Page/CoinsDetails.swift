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
            Text(coin.name ?? "Unknown Coin").font(.largeTitle).bold()
            Text("Symbol: \(coin.symbol?.uppercased() ?? "N/A")").font(.title2).foregroundColor(.gray)
            Spacer()
        }
        .padding()
        .navigationTitle("Coin Details")
    }
}
