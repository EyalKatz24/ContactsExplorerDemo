//
//  OnFirstAppearModifier.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

fileprivate struct OnFirstAppearModifier: ViewModifier {
    let perform: @MainActor () -> Void
    @State private var firstTime: Bool = true
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if firstTime {
                    firstTime = false
                    perform()
                }
            }
    }
}

public extension View {
    func onFirstAppear(perform: @MainActor @escaping () -> Void ) -> some View {
        modifier(OnFirstAppearModifier(perform: perform))
    }
}
