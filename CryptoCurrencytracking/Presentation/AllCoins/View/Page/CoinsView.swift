//
//  AllCoinsView.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import SwiftUI

struct CoinsView: View {
    
    @StateObject private var viewModel: CoinsViewModel
    
    init(viewModel: CoinsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                CoinsSearchView(searchText: $viewModel.searchText)
                
                CoinsFilterView(showFavoritesOnly: $viewModel.showFavoritesOnly)
                
                AppStateView(state: $viewModel.state, tryAgainAction: tryAgain) {
                    CoinsListView(viewModel: viewModel)
                }
            }
            .navigationTitle("Coins")
            .onAppear {
                loadData()
            }
        }
    }
        
    private func tryAgain() {
        loadData()
    }
    
    private func loadData() {
        viewModel.state = .loading
        viewModel.currentPage = 1
        viewModel.fetchCoins()
    }
}
