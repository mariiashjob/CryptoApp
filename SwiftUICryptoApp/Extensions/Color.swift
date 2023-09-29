//
//  Color.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 18.09.2023.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
    static let launchTheme = LaunchTheme()
}

struct ColorTheme {
    
    let accentColor = Color("AccentColor")
    let backgroundColor = Color("BackgroundColor")
    let textColor = Color("TextColor")
    let placeholderColor = Color("PlaceholderColor")
    let secondaryText = Color("SecondaryText")
    let red = Color("Red")
    let green = Color("Green")
}

struct LaunchTheme {
    
    let accentColor = Color("LaunchAccentColor")
    let backgroundColor = Color("LaunchBackgroundColor")
}
