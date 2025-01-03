//
//  CryptoCurrencytrackingApp.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import SwiftUI

@main
struct CryptoCurrencytrackingApp: App {
    var body: some Scene {
        WindowGroup {
            CoinsView(viewModel: CoinsViewModel(fetchAllCoinsUseCase: FetchAllCoinsUseCase(repository: CryptoCurrencyRepoImpl(service: CryptoCurrencyService()))))
        }
    }
}
