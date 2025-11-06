//  
//  ContactDetailsInteractor.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Dependencies

struct ContactDetailsInteractor {
    
}

extension ContactDetailsInteractor: DependencyKey {
    static let liveValue = ContactDetailsInteractor()
    static let testValue = ContactDetailsInteractor()
}
