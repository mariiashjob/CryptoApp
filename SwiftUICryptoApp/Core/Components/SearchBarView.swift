//
//  SearchBarView.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 21.09.2023.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accentColor)
            ZStack(alignment: .leading) {
                if searchText.isEmpty {
                    Text("Search by name or symbol...")
                        .foregroundColor(Color.theme.placeholderColor)
                }
                
                TextField("", text: $searchText)
                    .foregroundColor(Color.theme.accentColor)
                    .disableAutocorrection(true)
                    .overlay(
                        Image(systemName: "xmark.circle.fill")
                            .padding()
                            .offset(x: 10)
                            .foregroundColor(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accentColor)
                            .opacity(searchText.isEmpty ? 0.0 : 1.0)
                            .onTapGesture {
                                UIApplication.shared.endEditing()
                                searchText = ""
                            },
                        alignment: .trailing
                    )
            }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.backgroundColor)
                .shadow(color: Color.theme.accentColor.opacity(0.5),
                        radius: 10.0, x: 0.0, y: 0.0)
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
