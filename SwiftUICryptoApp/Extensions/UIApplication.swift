//
//  UIApplication.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 21.09.2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
