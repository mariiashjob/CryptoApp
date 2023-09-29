//
//  XMarkButtonView.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 22.09.2023.
//

import SwiftUI

struct XMarkButtonView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
    }, label: {
        Image(systemName: "xmark")
            .font(.headline)
    })
    }
}

struct XMarkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButtonView()
    }
}
