//
//  RetrieveContactsUseCase.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies
import Services
import Models

struct RetrieveContactsUseCase {
    var retrieveContacts: () async -> Result<[Contact], ContactsError>
}

extension RetrieveContactsUseCase: DependencyKey {
    static let liveValue = RetrieveContactsUseCase(
        retrieveContacts: {
            @Dependency(\.services.contacts) var contactsService
            return await contactsService.retrieveContacts()
        }
    )
    
    static let testValue = RetrieveContactsUseCase(
        retrieveContacts: liveValue.retrieveContacts
    )
    
    static let previewValue = RetrieveContactsUseCase(
        retrieveContacts: {
            .success([])
        }
    )
}

extension DependencyValues {
    var retrieveContacts: () async -> Result<[Contact], ContactsError> {
        get { self[RetrieveContactsUseCase.self].retrieveContacts }
        set { self[RetrieveContactsUseCase.self].retrieveContacts = newValue }
    }
}
