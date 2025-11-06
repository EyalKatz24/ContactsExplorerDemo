//
//  GlassEffectWrapperModifer.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

fileprivate struct GlassEffectWrapperModifer: ViewModifier {
    
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffect()
        } else {
            content
        }
    }
}

public extension View {
    
    @ViewBuilder
    func glassEffectWrapper() -> some View {
        modifier(GlassEffectWrapperModifer())
    }
}
