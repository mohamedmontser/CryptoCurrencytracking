//
//  CoinsViewModel.swift
//  CryptoCurrencytracking
//
//  Created by Mostafa Aboghida on 28/12/2024.
//

import Foundation
import Combine


class CoinsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var coins: [CoinsResponseModel] = []
    @Published var filteredCoins: [CoinsResponseModel] = []
    @Published var state = AppState.loading
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    @Published var favoriteCoins: Set<String> = [] // Store favorite coin IDs
    @Published var showFavoritesOnly: Bool = false

    let pageSize = 30
    var currentPage = 1
    var hasMoreData = false
    
    // MARK: - Dependencies
    private let fetchAllCoinsUseCase: FetchAllCoinsUseCaseP
    private var cancellables = Set<AnyCancellable>()
    private var timerCancellable: AnyCancellable? // Timer publisher
    
    // MARK: - Initialization
    init(fetchAllCoinsUseCase: FetchAllCoinsUseCaseP) {
        self.fetchAllCoinsUseCase = fetchAllCoinsUseCase
        setupSearchDebounce()
        startAutoRefresh()
        bindFavoriteCoins()
    }
    
    deinit {
        timerCancellable?.cancel()
    }
    
    private func setupSearchDebounce() {
        // I made local search cause i couldn't find search key word in API
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.filterCoins()
            }
            .store(in: &cancellables)
    }
    
    private func startAutoRefresh() {
        timerCancellable = Timer
            .publish(every: 30.0, on: .main, in: .common) // Fire every 30 seconds
            .autoconnect()
            .sink { [weak self] _ in
                self?.currentPage = 1
                self?.fetchCoins()
            }
    }
    
    private func bindFavoriteCoins() {
        $showFavoritesOnly
            .sink { [weak self] newValue in
                DispatchQueue.main.async {
                    self?.filterCoins()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Fetch Coins
    func fetchCoins() {
        errorMessage = nil
        
        let request = createRequestModel()
        
        fetchAllCoinsUseCase.execute(request: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.handleCompletion(completion)
            }, receiveValue: { [weak self] coins in
                self?.handleCoinsResponse(coins)
            })
            .store(in: &cancellables)
    }
    
    // MARK: - Request Model Creation
    private func createRequestModel() -> CoinsRequestModel {
        return CoinsRequestModel(
            vs_currency: "usd",
            order: .desc,
            per_page: pageSize,
            page: currentPage
        )
    }
    
    // MARK: - Completion Handler
    private func handleCompletion(_ completion: Subscribers.Completion<Error>) {
        
        if case let .failure(error) = completion {
            if currentPage == 1 && searchText.isEmpty {
                coins.removeAll()
                state = .error(error.localizedDescription)
            } else if !searchText.isEmpty {
                coins.removeAll()
                state = .searchEmptyResult("No coins found")
            } else {
                state = .success
            }
        }
    }
    
    // MARK: - Response Handler
    private func handleCoinsResponse(_ coins: [CoinsResponseModel]) {
        state = .success
        
        if currentPage == 1 {
            self.coins = coins
        } else {
            self.coins.append(contentsOf: coins)
        }
        
        hasMoreData = coins.count == pageSize
        filterCoins()
        currentPage += 1
    }
    
    private func filterCoins() {
        if searchText.isEmpty {
            filteredCoins = coins
        } else {
            filteredCoins = coins.filter {
                $0.name?.lowercased().contains(searchText.lowercased()) ?? false ||
                $0.symbol?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
        
        // Apply favorites filter if needed
        if showFavoritesOnly {
            filteredCoins = filteredCoins.filter { isFavorite(coin: $0) }
        }
    }
    
    func toggleFavorite(for coin: CoinsResponseModel) {
        if let id = coin.id {
            if !FavoriteManager.shared.getFavorites().contains(where: {$0.id == id}) {
                FavoriteManager.shared.addFavorite(coin)
            } else {
                FavoriteManager.shared.removeFavorite(byID: coin.id ?? "")
            }
        }

        onFavoriteUpdate()
    }
    
    private func onFavoriteUpdate() {
        filterCoins()
    }
    
    func isFavorite(coin: CoinsResponseModel) -> Bool {
        FavoriteManager.shared.isFavorite(coinID: coin.id ?? "")
    }
}
