//
//  AppUseCases.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Dependencies
import Models

public struct AppUseCases {
    public var openSettings: () async -> Void
}

extension AppUseCases: DependencyKey {
    public static let liveValue = AppUseCases(
        openSettings: {
            @Dependency(\.openAppSettings) var openAppSettings
            await openAppSettings()
        }
    )
}

public extension DependencyValues {
    var app: AppUseCases {
        get { self[AppUseCases.self] }
    }
}
