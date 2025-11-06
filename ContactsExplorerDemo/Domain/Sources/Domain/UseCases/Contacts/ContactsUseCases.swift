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
    public var toggleContactFavoriteStatus: (Contact) async -> Void
    public var requestContactsAuthorization: () async -> Bool
    public var didRetrieveContacts: () async -> Bool
    public var filterUsingQuery: (String) async -> [Contact]
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
        toggleContactFavoriteStatus: { contact in
            @Dependency(\.toggleContactFavoriteStatus) var toggleContactFavoriteStatus
            return await toggleContactFavoriteStatus(contact)
        },
        requestContactsAuthorization: {
            @Dependency(\.requestContactsAuthorization) var requestContactsAuthorization
            return await requestContactsAuthorization()
        },
        didRetrieveContacts: {
            @Dependency(\.didRetrieveContacts) var didRetrieveContacts
            return await didRetrieveContacts()
        },
        filterUsingQuery: { query in
            @Dependency(\.filterContactsUsingQuery) var filterContactsUsingQuery
            return await filterContactsUsingQuery(query)
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
