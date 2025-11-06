//  
//  ContactsInteractor.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Dependencies

struct ContactsInteractor {
    
}

extension ContactsInteractor: DependencyKey {
    static let liveValue = ContactsInteractor()
    static let testValue = ContactsInteractor()
}
