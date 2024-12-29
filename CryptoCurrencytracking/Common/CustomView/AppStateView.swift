//
//  AppStateView.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 29/12/2024.
//

import Foundation
import SwiftUI



struct AppStateView<Content: View>: View {
    
    
    @Binding var state: AppState
    var tryAgainAction: (() -> Void)?
    var action: (() -> Void)?
    var pageTitle: LocalizedStringKey? = nil
    var content: Content
    var padding: Double
    var stateError: String
    @State private var bottomPadding: CGFloat = 0
    
    init(state: Binding<AppState> , pageTitle: LocalizedStringKey? = nil, padding: Double = 20,stateError:String = "-" ,tryAgainAction: (() -> ())? , @ViewBuilder content: () -> Content) {
        self._state =  state
        self.content = content()
        self.pageTitle = pageTitle
        self.padding = padding
        self.tryAgainAction = tryAgainAction
        self.stateError = stateError
    }
    
    var body: some View {

        VStack {
            
            ZStack{
                content
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                VStack {
                    if self.state == .loading {
                        VStack {
                            Loader()
                        }
                        .background(SwiftUI.Color.white)
                        .ignoresSafeArea()
                    }
                    
                    if tryAgian {
                        StateTryAgainView(action: makeAction)
                    }
                    
                    if noData {
                        NoDataView()
                    }
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(self.state == .success ? Color.red : Color.white)
                .cornerRadius(20)
                .opacity(stateViewSwiftUIOpacity)
                
                
                HStack {
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
    
    
    var stateViewSwiftUIOpacity: Double {
        state == .success ? 0: 1
    }
    
    var startLoading: Bool {
        state == .loading
    }
    
    var tryAgian: Bool {
        if case .error(_) = state {
            return true
        }else {
            return false
        }
    }
    
    var noData: Bool {
        state == .emptyData
    }
        
    func makeAction() {
        self.tryAgainAction?()
    }
}


struct ErrorWithTitle: View {
    let error: String?
    var body: some View {
        VStack {
            Image(Images.errorDailog.rawValue)
                .frame(width: 30, height: 30)
                .padding(.bottom,30)
                .padding(.vertical,12)
            
            Text("Some thing went wrong")
                .font(.headline)
                .padding(.vertical,12)

            Text(error ?? "")
                .font(.body)
                .multilineTextAlignment(.center)
                            
            .padding(.horizontal, 15)
        }
    }
}



struct StateTryAgainView: View {
    var action: () -> ()
    
    var body: some View {
        VStack {
            Image(Images.errorDailog.rawValue)
                .frame(width: 30, height: 30)
                .padding(.bottom,30)
            
            Text("Some thing went wrong")
                .font(.headline)
                .padding(.vertical,12)
                .multilineTextAlignment(.center)

            Button (action: action) {
                Text("Try Again")
            }
        }
    }
}


struct NoDataView: View {
    
    var body: some View {
        VStack() {
            
            Image(Images.noResults.rawValue)
                .frame(width: 30, height: 30)
                .padding(.bottom,50)
            
            Text("No results found")
                .font(.headline)
            
        }
    }
}



