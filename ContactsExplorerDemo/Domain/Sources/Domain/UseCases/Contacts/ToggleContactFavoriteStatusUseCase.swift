//  
//  ToggleContactFavoriteStatusUseCase.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies
import Models
import Sharing
import IdentifiedCollections

struct ToggleContactFavoriteStatusUseCase {
    var toggleContactFavoriteStatus: (Contact) async -> Void
}

extension ToggleContactFavoriteStatusUseCase: DependencyKey {
    static let liveValue = ToggleContactFavoriteStatusUseCase(
        toggleContactFavoriteStatus: { contact in
            @Dependency(\.services.contacts) var contactsService
            await contactsService.toggleContactFavoriteStatus(contact)
        }
    )
    
    static let testValue = ToggleContactFavoriteStatusUseCase(
        toggleContactFavoriteStatus: liveValue.toggleContactFavoriteStatus
    )
}

extension DependencyValues {
    var toggleContactFavoriteStatus: (Contact) async -> Void {
        get { self[ToggleContactFavoriteStatusUseCase.self].toggleContactFavoriteStatus }
        set { self[ToggleContactFavoriteStatusUseCase.self].toggleContactFavoriteStatus = newValue }
    }
}
