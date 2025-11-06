//  
//  ContactsView.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

@ViewAction(for: ContactsStore.self)
public struct ContactsView: View {
    
    @Bindable public var store: StoreOf<ContactsStore>
    
    public init(store: StoreOf<ContactsStore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Text("Contacts")
        }
        .font(.largeTitle)
        .onFirstAppear {
            send(.onFirstAppear)
        }
    }
}

#Preview {
    NavigationStack {
        ContactsView(
            store: Store(
                initialState: ContactsStore.State(),
                reducer: ContactsStore.init
            )
        )
    }
}
