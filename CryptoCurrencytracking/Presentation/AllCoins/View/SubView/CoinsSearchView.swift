//
//  CoinsSearchView.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 29/12/2024.
//

import SwiftUI

struct CoinsSearchView: View {
   
    @Binding var searchText: String
    
    var body: some View {
        TextField("Search Coins...", text: $searchText)
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}
