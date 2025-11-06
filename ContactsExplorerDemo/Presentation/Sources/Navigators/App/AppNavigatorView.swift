//  
//  AppNavigatorView.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import ComposableArchitecture
import Contacts
import DesignSystem

public extension AppNavigator {
    
    struct ContentView: View {
        
        @Bindable public var store: StoreOf<AppNavigator>
        
        public init(store: StoreOf<AppNavigator>) {
            self.store = store
        }
        
        public var body: some View {
            NavigationStack(
                path: $store.scope(state: \.path, action: \.path),
                root: {
                    ContactsView(store: store.scope(state: \.root, action: \.root))
                },
                destination: { store in
                    WithPerceptionTracking {
                        switch store.case {
                            // Remove if you don't have any other module in this navigator
                        }
                    }
                }
            )
            .fullScreenCover(
                item: $store.scope(state: \.destination, action: \.destination),
                content: { store in
                    WithPerceptionTracking {
                        switch store.case {
                            // Remove if you don't need any presentation
                        }
                    }
                }
            )
        }
    }
}
