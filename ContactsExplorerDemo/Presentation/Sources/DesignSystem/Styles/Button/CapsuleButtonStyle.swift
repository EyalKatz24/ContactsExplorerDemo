//
//  CapsuleButtonStyle.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

public struct CapsuleButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 26.0, *) {
            configuration.label
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(Color.accentColor)
                )
                .foregroundColor(.white)
                .opacity(configuration.isPressed ? 0.8 : 1.0)
                .glassEffect(.regular.interactive(isEnabled), in: .capsule)
                .clipShape(.capsule)
        } else {
            configuration.label
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(Color.accentColor)
                )
                .foregroundColor(.white)
                .opacity(configuration.isPressed ? 0.6 : 1.0)
                .clipShape(.capsule)
        }
    }
}

public extension ButtonStyle where Self == CapsuleButtonStyle {
    static var capsule: CapsuleButtonStyle {
        CapsuleButtonStyle()
    }
}

#Preview {
    Button("Hello") {
        
    }
    .buttonStyle(.capsule)
}
