//
//  GroupedModifier.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

fileprivate struct GroupedModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .clipShape(.rect(cornerRadius: DesignSystem.CornerRadius.grouping))
                .glassEffect(in: .rect(cornerRadius: DesignSystem.CornerRadius.grouping))
        } else {
            content
                .clipShape(.rect(cornerRadius: DesignSystem.CornerRadius.grouping))
                .background(
                    RoundedRectangle(cornerRadius: DesignSystem.CornerRadius.grouping)
                        .fill(.ultraThinMaterial)
                )
        }
    }
}

public extension View {
    
    @ViewBuilder
    func grouped() -> some View {
        modifier(GroupedModifier())
    }
}
