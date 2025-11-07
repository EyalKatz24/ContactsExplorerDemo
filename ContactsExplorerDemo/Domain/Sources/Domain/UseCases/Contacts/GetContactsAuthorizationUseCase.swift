//
//  GetContactsAuthorizationUseCase.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies
import Models

struct GetContactsAuthorizationUseCase {
    var getContactsAuthorization: () -> ContactsAuthorization
}

extension GetContactsAuthorizationUseCase: DependencyKey {
    static let liveValue = GetContactsAuthorizationUseCase(
        getContactsAuthorization: {
            @Dependency(\.services.contacts) var contactsService
            return contactsService.authorization
        }
    )
    
    static let testValue = GetContactsAuthorizationUseCase(
        getContactsAuthorization: liveValue.getContactsAuthorization
    )
    
    static let previewValue = GetContactsAuthorizationUseCase(
        getContactsAuthorization: { .permitted }
    )
}

extension DependencyValues {
    var getContactsAuthorization: () -> ContactsAuthorization {
        get { self[GetContactsAuthorizationUseCase.self].getContactsAuthorization }
        set { self[GetContactsAuthorizationUseCase.self].getContactsAuthorization = newValue }
    }
}
