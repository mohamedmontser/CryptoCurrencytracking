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
                // Search Bar
                CoinsSearchView(searchText: $viewModel.searchText)
                
                CoinsFilterView(showFavoritesOnly: $viewModel.showFavoritesOnly)
                
                AppStateView(state: $viewModel.state, tryAgainAction: tryAgain, backAction: nil) {
                    CoinsListView(viewModel: $viewModel)
                }
            }
            .navigationTitle("Coins")
            .onAppear {
                viewModel.state = .loading
                viewModel.currentPage = 1
                viewModel.fetchCoins()
            }
        }
    }
    
    func canLoadMore(model: CoinsResponseModel) -> any View {
        if viewModel.hasMoreData && viewModel.currentPage > 1 && model.id == viewModel.coins.last?.id {
            return Loader(size: 30)
                .id(UUID())
                .onAppear(perform: {
                    viewModel.fetchCoins()
                })
        }else{
            return  EmptyView()
        }
    }
    
    func tryAgain() {
        
    }
}
