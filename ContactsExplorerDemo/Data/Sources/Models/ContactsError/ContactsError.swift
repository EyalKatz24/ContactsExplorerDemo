//
//  ContactsError.swift
//  Data
//
//  Created by Eyal Katz on 07/11/2025.
//

import Foundation

/// Currently represents demo errors that could be handled (some `CNError` equivalent).
public enum ContactsError: Error, Equatable {
    case general
    case contactsAuthorizationDenied
    case contactsDataAccessError
}
