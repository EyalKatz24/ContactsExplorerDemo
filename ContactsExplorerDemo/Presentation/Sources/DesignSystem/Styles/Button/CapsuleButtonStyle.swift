//
//  CapsuleButtonStyle.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

public struct CapsuleButtonStyle: ButtonStyle {
    
    // TODO: liquid glass support
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(Color.accentColor)
            )
            .foregroundColor(.white)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
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
