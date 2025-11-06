//
//  ContactAction+Extension.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import Models
import InternalUtilities

public extension ContactAction {
    
    // Optional future management, that's only for demo purposes
    var isEnabled: Bool {
        switch self {
        case .favoriteToggle:
            true
        case .message:
            false
        }
    }
    
    func imageSystemName(isFavorite: Bool) -> String {
        switch self {
        case .favoriteToggle:
            isFavorite ? "star.slash" : "star"
        case .message:
            "message"
        }
    }
    
    func title(isFavorite: Bool) -> Localization {
        switch self {
        case .favoriteToggle:
            isFavorite ? .removeFromFavorites : .addToFavorites
        case .message:
            .messageDemoAction
        }
    }
}
