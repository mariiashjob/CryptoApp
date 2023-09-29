//
//  SettingsView.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 28.09.2023.
//

import SwiftUI

struct SettingsView: View {
    
    private let telegramURL = URL(string: "https://t.me/MariiaLine")
    private let emailURL = URL(string: "mailto:\(Self.email)")
    private static let email = "mariiashjob@gmail.com"
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Swift Crypto App")) {
                    VStack(alignment: .leading) {
                        Image("logo")
                             .resizable()
                             .frame(width: 100, height: 100)
                             .clipShape(RoundedRectangle(cornerRadius: 20))
                         Text("This app was made following by @SwiftfullThinking course on Youtube. It uses MVVM architecture, Combine and CoreData.")
                             .font(.callout)
                             .fontWeight(.medium)
                             .foregroundColor(Color.theme.textColor)
                    }
                    .padding(.vertical)
                }
                
                Section(header: Text("My contacts")) {
                    if let telegramURL, let emailURL {
                        Link("Telegram: @MariiaLine", destination: telegramURL)
                        Link("Email: \(Self.email)", destination: emailURL)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButtonView()
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
