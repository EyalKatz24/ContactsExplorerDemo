//
//  LabelButtonStyle.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

public struct LabelButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    public func makeBody(configuration: Configuration) -> some View {
        if #available(iOS 26.0, *) {
            configuration.label
                .foregroundColor(.primary)
                .tint(.primary)
                .padding(16)
                .background(.thickMaterial)
                .grouped()
                .glassEffect(
                    .regular.interactive(isEnabled),
                    in: .rect(cornerRadius: DesignSystem.CornerRadius.grouping)
                )
                .clipShape(.rect(cornerRadius: DesignSystem.CornerRadius.grouping))
        } else {
            configuration.label
                .foregroundColor(.primary)
                .tint(.primary)
                .padding(16)
                .background(.thickMaterial)
                .grouped()
                .opacity(configuration.isPressed ? 0.8 : 1.0)
        }
    }
}

public extension ButtonStyle where Self == LabelButtonStyle {
    static var label: LabelButtonStyle {
        LabelButtonStyle()
    }
}

#Preview {
    Button("Share Profile") {
        
    }
    .buttonStyle(.label)
}

