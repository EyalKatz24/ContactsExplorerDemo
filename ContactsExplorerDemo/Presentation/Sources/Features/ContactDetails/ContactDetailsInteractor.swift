//  
//  ContactDetailsInteractor.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Dependencies
import Models
import Domain

struct ContactDetailsInteractor {
    @Dependency(\.contacts.getContactById) private var getContactById
    @Dependency(\.contacts.toggleContactFavoriteStatus) var toggleContactFavoriteStatus
    
    func getUpdatedData(for contact: Contact) -> Contact? {
        getContactById(contact.id)
    }
}

extension ContactDetailsInteractor: DependencyKey {
    static let liveValue = ContactDetailsInteractor()
    static let testValue = ContactDetailsInteractor()
}
