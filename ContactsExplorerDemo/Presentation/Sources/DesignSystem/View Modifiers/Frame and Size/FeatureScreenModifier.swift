//
//  FeatureScreenModifier.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

fileprivate struct FeautreScreenModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

public extension View {

    func featureScreen() -> some View {
        modifier(FeautreScreenModifier())
    }
}
