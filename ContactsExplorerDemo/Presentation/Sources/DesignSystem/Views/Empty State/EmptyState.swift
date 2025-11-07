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
    case contactsUnknownError
    case noContactsAuthorization
    case contactsDataAccessError
    
    var imageSystemName: String {
        switch self {
        case .noContactSearchResults:
            "magnifyingglass"
        case .noContactsToDisplay:
            "person.2"
        case .noContactsAuthorization:
            "person.crop.circle.badge.exclamationmark"
        case .contactsUnknownError, .contactsDataAccessError:
            "exclamationmark.circle"
        }
    }

    var title: Localization {
        switch self {
        case .noContactSearchResults:
            .noContactSearchResults
        case .noContactsToDisplay:
            .noContactsToDisplay
        case .contactsUnknownError:
            .contactsUnknownErrorTitle
        case .noContactsAuthorization:
            .contactsAccessDenied
        case .contactsDataAccessError:
            .contactsDataAccessErrorTitle
        }
    }
    
    var message: Localization {
        switch self {
        case let .noContactSearchResults(searchText):
            .noResultsFor(searchText: searchText)
        case .noContactsToDisplay:
            .noContactsToDisplayMessage
        case .contactsUnknownError:
            .contactsUnknownErrorMessage
        case .noContactsAuthorization:
            .enableContactsAccessInSettings
        case .contactsDataAccessError:
            .contactsDataAccessErrorMessage
        }
    }
    
    var buttonTitle: Localization? {
        switch self {
        case .noContactsAuthorization:
            .openSettings
        case .contactsUnknownError:
            .retry
        case .noContactSearchResults, .noContactsToDisplay, .contactsDataAccessError:
            nil
        }
    }
}
