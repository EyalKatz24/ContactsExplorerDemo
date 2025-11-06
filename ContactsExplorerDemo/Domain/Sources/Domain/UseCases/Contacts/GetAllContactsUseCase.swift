//
//  GetAllContactsUseCase.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Sharing
import Dependencies
import Models

struct GetAllContactsUseCase {
    var getAllContacts: () -> [Contact]
}

extension GetAllContactsUseCase: DependencyKey {
    static let liveValue = GetAllContactsUseCase(
        getAllContacts: {
            @Shared(.allContacts) var allContacts: [Contact] = []
            return allContacts
        }
    )
    
    static let testValue = GetAllContactsUseCase(
        getAllContacts: liveValue.getAllContacts
    )
}

extension DependencyValues {
    var getAllContacts: () -> [Contact] {
        get { self[GetAllContactsUseCase.self].getAllContacts }
        set { self[GetAllContactsUseCase.self].getAllContacts = newValue }
    }
}
