//
//  ErrorView.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import SwiftUI


struct ErrorView: View {
    let errorMessage: String

    var body: some View {
        Text(errorMessage)
            .foregroundColor(.red)
            .padding()
    }
}
