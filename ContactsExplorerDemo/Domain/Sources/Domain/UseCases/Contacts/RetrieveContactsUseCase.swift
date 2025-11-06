//
//  RetrieveContactsUseCase.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies
import Services

struct RetrieveContactsUseCase {
    var retrieveContacts: () async -> Void
}

extension RetrieveContactsUseCase: DependencyKey {
    static let liveValue = RetrieveContactsUseCase(
        retrieveContacts: {
            @Dependency(\.services.contacts) var contactsService
            await contactsService.retrieveContacts()
        }
    )
    
    static let testValue = RetrieveContactsUseCase(
        retrieveContacts: liveValue.retrieveContacts
    )
}

extension DependencyValues {
    var retrieveContacts: () async -> Void {
        get { self[RetrieveContactsUseCase.self].retrieveContacts }
        set { self[RetrieveContactsUseCase.self].retrieveContacts = newValue }
    }
}
