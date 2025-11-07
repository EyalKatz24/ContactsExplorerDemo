//
//  Effect+ActionDebounce.swift
//  Presentation
//
//  Created by Eyal Katz on 07/11/2025.
//

import Foundation
import ComposableArchitecture

public extension Effect {
    enum ActionDebounce {
        case shimmer
        
        var duration: TimeInterval {
            switch self {
            case .shimmer: 0.5
            }
        }
        
        var scheduler: AnySchedulerOf<DispatchQueue> {
            // In case background/other queue is needed - use a switch statement here
            @Dependency(\.mainQueue) var mainQueue
            return mainQueue
        }
    }
    
    private func id(for type: ActionDebounce) -> String {
        "\(Action.self)-\(type)"
    }

    /// Turns an effect into one that can be debounced according to the `ActionDebounce` behavior parameter.
    ///
    /// The scheduler delivers the debounced output to, is set by the `type` parameter.
    ///
    /// - Parameters:
    ///   - type: The `ActionDebounce` behavior.
    ///
    /// - Returns: An effect that publishes events only after the `type.duration` elapses.
    func debounce(for type: ActionDebounce) -> Self {
        debounce(id: id(for: type), for: .seconds(type.duration), scheduler: type.scheduler)
    }
}
