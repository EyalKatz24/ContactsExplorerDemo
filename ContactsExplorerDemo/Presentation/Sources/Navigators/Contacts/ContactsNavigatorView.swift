//  
//  ContactsNavigatorView.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import ContactsFeature

public extension ContactsNavigator {
    
    struct ContentView: View {
        
        @Bindable public var store: StoreOf<ContactsNavigator>
        
        public init(store: StoreOf<ContactsNavigator>) {
            self.store = store
        }
        
        public var body: some View {
            NavigationStack(
                path: $store.scope(state: \.path, action: \.path),
                root: {
                    ContactsView(store: store.scope(state: \.root, action: \.root))
                },
                destination: { store in
                    // Future dev
//                    switch store.case {
//
//                    }
                }
            )
        }
    }
}
