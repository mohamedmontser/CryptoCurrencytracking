//
//  Loader.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 29/12/2024.
//

import SwiftUI

struct Loader: View {
    var size: Double = 70
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                ProgressView()
                    .frame(width: size, height: size)
                    .foregroundColor(Color.red)
                Spacer()
            }
        }
    }
}


#Preview {
    Loader()
}
