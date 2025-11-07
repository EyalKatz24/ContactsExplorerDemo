//  
//  GetContactByIdUseCase.swift
//  Domain
//
//  Created by Eyal Katz on 07/11/2025.
//

import Sharing
import Dependencies
import IdentifiedCollections
import Models

struct GetContactByIdUseCase {
    var getContactById: (String) -> Contact?
}

extension GetContactByIdUseCase: DependencyKey {
    static let liveValue = GetContactByIdUseCase(
        getContactById: { contactId in
            @Shared(.allContacts) var allContacts: IdentifiedArrayOf<Contact> = []
            return allContacts[id: contactId]
        }
    )
    
    static let testValue = GetContactByIdUseCase(
        getContactById: liveValue.getContactById
    )
}

extension DependencyValues {
    var getContactById: (String) -> Contact? {
        get { self[GetContactByIdUseCase.self].getContactById }
        set { self[GetContactByIdUseCase.self].getContactById = newValue }
    }
}
