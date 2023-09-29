//
//  String.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 28.09.2023.
//

import Foundation

extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
