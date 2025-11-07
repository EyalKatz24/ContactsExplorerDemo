//
//  RequestContactsAuthorizationUseCase.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies

fileprivate struct RequestContactsAuthorizationUseCase {
    var requestContactsAuthorization: () async -> Bool
}

extension RequestContactsAuthorizationUseCase: DependencyKey {
    static let liveValue = RequestContactsAuthorizationUseCase(
        requestContactsAuthorization: {
            @Dependency(\.services.contacts) var contactsService
            return await contactsService.requestContactsPermission()
        }
    )
    
    static let testValue = RequestContactsAuthorizationUseCase(
        requestContactsAuthorization: liveValue.requestContactsAuthorization
    )
    
    static let previewValue = RequestContactsAuthorizationUseCase(
        requestContactsAuthorization: { true }
    )
}

extension DependencyValues {
    var requestContactsAuthorization: () async -> Bool {
        get { self[RequestContactsAuthorizationUseCase.self].requestContactsAuthorization }
        set { self[RequestContactsAuthorizationUseCase.self].requestContactsAuthorization = newValue }
    }
}
