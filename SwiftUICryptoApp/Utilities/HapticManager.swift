//
//  HapticManager.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 26.09.2023.
//

import Foundation
import UIKit

final class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
