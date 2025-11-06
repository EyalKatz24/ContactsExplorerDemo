//
//  EmptyState.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import InternalUtilities

public enum EmptyState {
    case noContactSearchResults(searchText: String)
    case noContactsToDisplay
    case noContactsAuthorization
    
    var imageSystemName: String {
        switch self {
        case .noContactSearchResults:
            "magnifyingglass"
        case .noContactsToDisplay:
            "person.2"
        case .noContactsAuthorization:
            "person.crop.circle.badge.exclamationmark"
        }
    }

    var title: Localization {
        switch self {
        case .noContactSearchResults:
            .noContactSearchResults
        case .noContactsToDisplay:
            .noContactsToDisplay
        case .noContactsAuthorization:
            .contactsAccessDenied
        }
    }
    
    var message: Localization {
        switch self {
        case let .noContactSearchResults(searchText):
            .noResultsFor(searchText: searchText)
        case .noContactsToDisplay:
            .noContactsToDisplayMessage
        case .noContactsAuthorization:
            .enableContactsAccessInSettings
        }
    }
    
    var buttonTitle: Localization? {
        switch self {
        case .noContactSearchResults:
            nil
        case .noContactsToDisplay:
            nil
        case .noContactsAuthorization:
            .openSettings
        }
    }
}
