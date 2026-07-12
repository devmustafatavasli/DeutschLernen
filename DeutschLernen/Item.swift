//
//  Item.swift
//  DeutschLernen
//
//  Created by Mustafa TAVASLI on 12.07.2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
