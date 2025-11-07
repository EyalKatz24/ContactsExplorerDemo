//
//  Services.swift
//  Data
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies

public struct Services {
    public let contacts = ContactsService()
}

extension Services: DependencyKey {
    public static let liveValue = Services()
    public static let testValue = Services()
}

public extension DependencyValues {
    var services: Services {
        get { self[Services.self] }
    }
}
