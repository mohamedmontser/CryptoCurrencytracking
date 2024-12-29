//
//  CoinsListView.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 29/12/2024.
//

import SwiftUI
import Combine

struct CoinsListView: View {

    @ObservedObject var viewModel: CoinsViewModel
    
    var body: some View {
        if viewModel.filteredCoins.isEmpty {
            noDataView
        } else {
            listView
        }
        
    }
    
    var listView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.filteredCoins, id: \.id) { coin in
                    VStack {
                        CoinRowView(coin: coin, isFavorite: viewModel.isFavorite(coin: coin), viewModel: viewModel) {
                            viewModel.toggleFavorite(for: coin)
                        }
                        AnyView(canLoadMore(model: coin))
                    }
                }
            }
        }
    }
    
    var noDataView: some View {
        VStack {
            Spacer()
            NoDataView()
            Spacer()
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

}
