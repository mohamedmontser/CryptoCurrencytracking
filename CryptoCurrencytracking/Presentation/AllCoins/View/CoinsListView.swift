//
//  AllCoinsView.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import SwiftUI

struct AllCoinsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AllCoinsView()
}


struct CoinsListView: View {
    @StateObject private var viewModel = CoinsViewModel()
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search coins...", text: $searchQuery, onEditingChanged: { _ in
                    viewModel.searchCoins(query: searchQuery)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                List(viewModel.filteredCoins, id: \.id) { coin in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(coin.name).font(.headline)
                            Text(coin.symbol.uppercased()).font(.subheadline).foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            viewModel.toggleFavorite(coinID: coin.id)
                        }) {
                            Image(systemName: viewModel.isFavorite(coinID: coin.id) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    .onTapGesture {
                        // Navigate to details view
                    }
                }
            }
            .navigationTitle("Cryptocurrencies")
            .onAppear {
                viewModel.fetchCoins()
            }
        }
    }
}
