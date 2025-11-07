//  
//  ContactsInteractor.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Dependencies
import Domain
import Models

struct ContactsInteractor {
    @Dependency(\.contacts.all) private var getAllContacts
    @Dependency(\.contacts.authorization) private var getContactsAuthorization
    @Dependency(\.contacts.filterUsingQuery) private var filterContactsUsingQuery
    @Dependency(\.contacts.didRetrieveContacts) var didRetrieveContacts
    @Dependency(\.contacts.retrieveAll) var retrieveContacts
    @Dependency(\.contacts.requestContactsAuthorization) var requestContactsAuthorization
    @Dependency(\.contacts.toggleContactFavoriteStatus) var toggleContactFavoriteStatus
    @Dependency(\.app.openSettings) var openAppSettings
    
    var allContacts: [Contact] {
        getAllContacts()
    }
    
    var contactsAuthorization: ContactsAuthorization {
        getContactsAuthorization()
    }
    
    func filterContacts(using query: String) async -> [Contact] {
        await filterContactsUsingQuery(query)
    }
}

extension ContactsInteractor: DependencyKey {
    static let liveValue = ContactsInteractor()
    static let testValue = ContactsInteractor()
}
