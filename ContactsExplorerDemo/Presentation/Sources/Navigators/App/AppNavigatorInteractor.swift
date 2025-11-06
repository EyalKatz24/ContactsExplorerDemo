//
//  AppNavigatorInteractor.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies
import Domain

struct AppNavigatorInteractor {

}

extension AppNavigatorInteractor: DependencyKey {
    static let liveValue = AppNavigatorInteractor()
    static let testValue = AppNavigatorInteractor()
}
