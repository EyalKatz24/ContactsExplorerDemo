//
//  Contact+Action.swift
//  Data
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation

public typealias ContactAction = Contact.Action

public extension Contact {
    
    // Optional future management, that's only for demo purposes
    var actions: [ContactAction] {
        [.favoriteToggle, .message]
    }
    
    enum Action: Equatable {
        case favoriteToggle
        case message // Demo, not working
    }
}
