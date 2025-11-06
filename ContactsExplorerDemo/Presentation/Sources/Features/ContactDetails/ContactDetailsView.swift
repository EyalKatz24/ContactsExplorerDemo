//  
//  ContactDetailsView.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Models

@ViewAction(for: ContactDetailsStore.self)
public struct ContactDetailsView: View {
    
    @Bindable public var store: StoreOf<ContactDetailsStore>
    
    public init(store: StoreOf<ContactDetailsStore>) {
        self.store = store
    }
    
    public var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ContactImage(
                    contact: store.contact,
                    size: .fixedLarge
                )
                .padding(.top, 24)
                
                header()
                    .padding(.top, 16)
                    
                detailsView()
                    .padding(.top, 40)
            }
        }
        .featureScreen()
        .background {
            contactBackgroundGradient()
        }
        .onFirstAppear {
            send(.onFirstAppear)
        }
    }
    
    @ViewBuilder
    private func contactBackgroundGradient() -> some View {
        LinearGradient(
            colors: [
                .white.opacity(0.8),
                store.contact.averageColor
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationStack {
        ContactDetailsView(
            store: Store(
                initialState: ContactDetailsStore.State(
                    contact: Contact(
                        id: "12345",
                        imageData: nil,
                        firstName: "John",
                        lastName: "Doe",
                        phoneNumbers: [.init(label: "work", labelType: .other, number: "+1234567890")],
                        emails: [.init(label: "work", address: "john.appleseed@example.com")],
                        birthday: nil
                    )
                ),
                reducer: ContactDetailsStore.init
            )
        )
    }
}
