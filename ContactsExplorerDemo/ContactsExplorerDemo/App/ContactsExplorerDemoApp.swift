//
//  ContactsExplorerDemoApp.swift
//  ContactsExplorerDemo
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import AppNavigator
import ComposableArchitecture

@main
struct ContactsExplorerDemoApp: App {
    var body: some Scene {
        WindowGroup {
            AppNavigator.ContentView(
                store: Store(
                    initialState: AppNavigator.State(),
                    reducer: AppNavigator.init
                )
            )
        }
    }
}
