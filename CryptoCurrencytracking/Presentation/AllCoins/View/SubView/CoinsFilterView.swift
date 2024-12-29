//
//  CoinsFilterView.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 29/12/2024.
//

import SwiftUI

struct CoinsFilterView: View {
    @Binding var showFavoritesOnly: Bool
    
    var body: some View {
        Picker("Filter", selection: $showFavoritesOnly) {
            Text("All Coins").tag(false)
            Text("Favorites").tag(true)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.bottom)
        .padding(.horizontal)
    }
}
