//
//  Effect+Extension.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import ComposableArchitecture
import SwiftUI

public extension Effect {
    
    /// Initializes an effect that  emits the action passed in after a delay in seconds.
    ///
    /// - Parameters:
    ///   - action: The action that is emitted by the effect.
    ///   - delay: Amount of seconds to wait before the action is emitted.
    ///   - animation: An optional animation that will be attached to the action if not `nil`.
    static func send(_ action: Action, animation: Animation? = nil, after delay: TimeInterval) -> Effect<Action> {
        @Dependency(\.continuousClock) var clock
        
        return .run { send in
            try? await clock.sleep(for: .seconds(delay))
            if let animation {
                await send(action, animation: animation)
            } else {
                await send(action)
            }
        }
    }
}
