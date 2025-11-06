//
//  Localization.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Localized

@Localized(keyFormat: .lowerSnakeCase)
public enum Localization: Equatable {
    case myContactsTitle
    case searchContactsPrompt
    case email
    case emails
    case openSettings
    case noContactsToDisplay
    case noContactsToDisplayMessage
    case noContactSearchResults
    case noResultsFor(searchText: String)
    case checkYourSpellingOrTryDifferentKeywords
    case contactsAccessDenied
    case enableContactsAccessInSettings
    case addToFavorites
    case removeFromFavorites
    case messageDemoAction
    case birthday
    case phoneNumbers
    case markAsFavorite
    case markedAsFavorite
}
