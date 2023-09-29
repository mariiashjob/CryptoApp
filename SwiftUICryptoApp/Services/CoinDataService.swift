//
//  CoinDataService.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 20.09.2023.
//

import Foundation
import Combine

final class CoinDataService {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
  
    var coinSubsciption: AnyCancellable?
    
    init() {
        getCoins()
    }
    
    func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }
        
        coinSubsciption = NetworkingManager.download(url: url) // <- executed in background thread
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubsciption?.cancel()
            })
    }
}
