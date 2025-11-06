//
//  OpenAppSettingsUseCase.swift
//  Domain
//
//  Created by Eyal Katz on 06/11/2025.
//

import Dependencies
import UIKit

struct OpenAppSettingsUseCase {
    var openAppSettings: () async -> Void
}

extension OpenAppSettingsUseCase: DependencyKey {
    static let liveValue = OpenAppSettingsUseCase(
        openAppSettings: {
            @Dependency(\.openURL) var openURL
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            await openURL(url)
        }
    )
    
    static let testValue = OpenAppSettingsUseCase(
        openAppSettings: liveValue.openAppSettings
    )
}

extension DependencyValues {
    var openAppSettings: () async -> Void {
        get { self[OpenAppSettingsUseCase.self].openAppSettings }
        set { self[OpenAppSettingsUseCase.self].openAppSettings = newValue }
    }
}
