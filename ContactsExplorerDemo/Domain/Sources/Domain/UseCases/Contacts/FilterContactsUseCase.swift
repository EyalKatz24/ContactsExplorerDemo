//
//  FilterContactsUseCase.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Dependencies
import Models

struct FilterContactsUseCase {
    var filterContactsUsingQuery: (String) async -> [Contact]
}

extension FilterContactsUseCase: DependencyKey {
    static let liveValue = FilterContactsUseCase(
        filterContactsUsingQuery: { query in
            @Dependency(\.getAllContacts) var getAllContacts
            let allContacts = getAllContacts()
            let lowercasedQuery = query.lowercased()
            
            return await withCheckedContinuation { continuation in
                DispatchQueue.global(qos: .userInitiated).async {
                    var filteredContacts = allContacts.filter {
                        $0.fullName?.lowercased().contains(lowercasedQuery) ?? false ||
                        $0.phoneNumbers.contains(
                            where: { $0.number.replacingOccurrences(of: "-", with: "").lowercased().contains(lowercasedQuery) || $0.number.lowercased().contains(lowercasedQuery)
                            })
                    }
                    
                    continuation.resume(returning: filteredContacts)
                }
            }
        }
    )
    
    static let testValue = FilterContactsUseCase(
        filterContactsUsingQuery: liveValue.filterContactsUsingQuery
    )
}

extension DependencyValues {
    var filterContactsUsingQuery: (String) async -> [Contact] {
        get { self[FilterContactsUseCase.self].filterContactsUsingQuery }
        set { self[FilterContactsUseCase.self].filterContactsUsingQuery = newValue }
    }
}
