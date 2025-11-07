//
//  View+Extension.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func modify<Content: View>(@ViewBuilder _ transform: (Self) -> Content?) -> some View {
        if let view = transform(self) {
            view
        } else {
            self
        }
    }
    
    func leadingAligned() -> some View {
        frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func onReceive(notification: Notification.Name, perform action: @escaping (NotificationCenter.Publisher.Output) -> Void) -> some View {
        onReceive(NotificationCenter.default.publisher(for: notification), perform: action)
    }
}
