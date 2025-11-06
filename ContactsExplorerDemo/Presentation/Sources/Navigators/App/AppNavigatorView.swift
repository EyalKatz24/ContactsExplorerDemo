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
import InternalUtilities
import ContactsNavigator

public extension AppNavigator {
    
    @ViewAction(for: AppNavigator.self)
    struct ContentView: View {
        
        @Bindable public var store: StoreOf<AppNavigator>
        
        public init(store: StoreOf<AppNavigator>) {
            self.store = store
        }
        
        public var body: some View {
            NavigationStack(
                root: {
                    ContactsNavigator.ContentView(store: store.scope(state: \.root, action: \.root))
                }
            )
            .onFirstAppear { send(.onFirstAppear) }
        }
    }
}
