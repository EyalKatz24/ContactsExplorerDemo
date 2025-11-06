//
//  ContactsUseCases.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies
import Models

public struct ContactsUseCases {
    public var all: () -> [Contact]
    public var retrieveAll: () async -> Void
    public var requestContactsAuthorization: () async -> Bool
    public var authorization: () -> ContactsAuthorization
}

extension ContactsUseCases: DependencyKey {
    public static let liveValue = ContactsUseCases(
        all: {
            @Dependency(\.getAllContacts) var getAllContacts
            return getAllContacts()
        },
        retrieveAll: {
            @Dependency(\.retrieveContacts) var retrieveAllContacts
            return await retrieveAllContacts()
        },
        requestContactsAuthorization: {
            @Dependency(\.requestContactsAuthorization) var requestContactsAuthorization
            return await requestContactsAuthorization()
        },
        authorization: {
            @Dependency(\.getContactsAuthorization) var getContactsAuthorization
            return getContactsAuthorization()
        }
    )
}

public extension DependencyValues {
    var contacts: ContactsUseCases {
        get { self[ContactsUseCases.self] }
        set { self[ContactsUseCases.self] = newValue }
    }
}
