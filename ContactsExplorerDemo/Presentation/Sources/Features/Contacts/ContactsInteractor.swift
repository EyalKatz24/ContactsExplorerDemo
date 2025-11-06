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
    
    var allContacts: [Contact] {
        getAllContacts()
    }
    
    var contactsAuthorization: ContactsAuthorization {
        getContactsAuthorization()
    }
}

extension ContactsInteractor: DependencyKey {
    static let liveValue = ContactsInteractor()
    static let testValue = ContactsInteractor()
}
