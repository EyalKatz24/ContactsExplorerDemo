//
//  DidRetrieveContactsUseCase.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies

struct DidRetrieveContactsUseCase {
    var didRetrieveContacts: () async -> Bool
}

extension DidRetrieveContactsUseCase: DependencyKey {
    static let liveValue = DidRetrieveContactsUseCase(
        didRetrieveContacts: {
            @Dependency(\.services.contacts) var contactsService
            return await contactsService.didRetrieveContacts
        }
    )
    
    static let testValue = DidRetrieveContactsUseCase(
        didRetrieveContacts: liveValue.didRetrieveContacts
    )
}

extension DependencyValues {
    var didRetrieveContacts: () async -> Bool {
        get { self[DidRetrieveContactsUseCase.self].didRetrieveContacts }
        set { self[DidRetrieveContactsUseCase.self].didRetrieveContacts = newValue }
    }
}
