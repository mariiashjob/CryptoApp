//
//  PortfolioView.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 22.09.2023.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quanityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
            
                    if selectedCoin != nil {
                        portfolioinputSection
                    }
                }
            }
                .background(Color.theme.backgroundColor)
                .navigationTitle("Edit Portfolio")
                .foregroundColor(Color.theme.accentColor)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        XMarkButtonView()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        trailingNavBarButtons
                    }
                })
                .onChange(of: vm.searchText) { newValue in
                    if newValue == "" {
                        removeSelectedCoin()
                    }
                }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 70)
                        .padding(6)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ?
                                        Color.theme.accentColor : Color.clear, lineWidth: 1)
                        )
                }
            }
            .frame(height: 150)
            .padding()
        }
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfoloioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfoloioCoin.currentHoldings {
            quanityText = "\(amount)"
        } else {
            quanityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quanity = Double(quanityText) {
            return quanity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var portfolioinputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Currnet price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimal() ?? "")
                    .font(.headline)
                    .bold()
            }
            Divider()
                .overlay(Color.theme.accentColor)
            HStack(alignment: .top) {
                Text("Amount holding: ")
                Spacer()
                ZStack(alignment: .trailing) {
                    if quanityText.isEmpty {
                        Text("Ex: 1.4")
                            .foregroundColor(Color.theme.placeholderColor)
                    }
                    TextField("", text: $quanityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                        .font(.headline)
                        .bold()
                }
            }
            Divider()
                .overlay(Color.theme.accentColor)
            HStack {
                Text("Currnet value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimal())
                    .font(.headline)
                    .bold()
            }
        }
        .foregroundColor(Color.theme.textColor)
        .padding()
    }
    
    private var trailingNavBarButtons: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("save".uppercased())
            }
            .opacity((selectedCoin != nil && selectedCoin?.currentHoldings != Double(quanityText)) ? 1.0 : 0.0)
        }
        .font(.headline)
    }
    
    private func saveButtonPressed() {
        
        guard
            let coin = selectedCoin,
            let amount = Double(quanityText)
        else {
            return
        }
        
        // save to portfolio
        vm.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
        quanityText = ""
    }
}
