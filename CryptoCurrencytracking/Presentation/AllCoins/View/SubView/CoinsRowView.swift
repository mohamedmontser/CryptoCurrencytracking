//
//  CoinsRowView.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 29/12/2024.
//

import SwiftUI


struct CoinRowView: View {
    let coin: CoinsResponseModel
    let isFavorite: Bool
    @ObservedObject var viewModel: CoinsViewModel
    let onFavoriteToggle: () -> Void
    
    var body: some View {
        HStack {
            NavigationLink(destination: CoinDetailsView(coin: coin)) {
                HStack {
                    Text(coin.name ?? "") // Example content
                    Spacer()
                    Text("\(coin.currentPrice ?? 0) $")
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Button(action: {
                viewModel.toggleFavorite(for: coin)
            }) {
                Image(systemName: viewModel.isFavorite(coin: coin) ? "star.fill" : "star")
                    .foregroundColor(viewModel.isFavorite(coin: coin) ? .yellow : .gray)
            }
        }
        .padding()
    }
}
