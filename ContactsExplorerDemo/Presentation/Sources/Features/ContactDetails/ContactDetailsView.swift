//  
//  ContactDetailsView.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem

@ViewAction(for: ContactDetailsStore.self)
public struct ContactDetailsView: View {
    
    @Bindable public var store: StoreOf<ContactDetailsStore>
    
    public init(store: StoreOf<ContactDetailsStore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            Text("ContactDetails")
        }
        .font(.largeTitle)
        .onAppear {
            send(.onAppear)
        }
    }
}

#Preview {
    NavigationStack {
        ContactDetailsView(
            store: Store(
                initialState: ContactDetailsStore.State(),
                reducer: ContactDetailsStore.init
            )
        )
    }
}
