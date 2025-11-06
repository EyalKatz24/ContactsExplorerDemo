//  
//  ContactDetailsInteractor.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Dependencies
import Domain

struct ContactDetailsInteractor {
    @Dependency(\.contacts.toggleContactFavoriteStatus) var toggleContactFavoriteStatus
}

extension ContactDetailsInteractor: DependencyKey {
    static let liveValue = ContactDetailsInteractor()
    static let testValue = ContactDetailsInteractor()
}
