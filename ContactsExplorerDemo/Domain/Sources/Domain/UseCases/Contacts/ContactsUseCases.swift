//
//  ContactsUseCases.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies
import Models

public struct ContactsUseCases {
    
}

extension ContactsUseCases: DependencyKey {
    public static let liveValue = ContactsUseCases()
}

public extension DependencyValues {
    var contacts: ContactsUseCases {
        get { self[ContactsUseCases.self] }
        set { self[ContactsUseCases.self] = newValue }
    }
}
