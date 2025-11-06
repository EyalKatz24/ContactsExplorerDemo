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
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    switch store.viewState {
                    case .loading:
                        loadingView()
                        
                    case .loaded:
                        if store.contacts.isEmpty {
                            emptyStateView(geometry)
                        } else {
                            loadedView()
                        }
                        
                    case .error:
                        errorView(geometry)
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)
            .animation(.smooth, value: store.viewState)
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle(.localized(.myContactsTitle))
            .searchable(
                text: $store.searchText.sending(\.onSearchTextChange),
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: .localized(.searchContactsPrompt)
            )
            .autocorrectionDisabled()
            .onFirstAppear {
                send(.onFirstAppear)
            }
        }
    }
    
    @ViewBuilder
    private func loadingView() -> some View {
        EmptyView() // TODO: Shimmering when items are ready
    }
    
    @ViewBuilder
    private func emptyStateView(_ geometry: GeometryProxy) -> some View {
        if store.searchText.isEmpty {
            EmptyStateView(
                type: .noContactsToDisplay,
                minHeight: geometry.size.height
            )
        } else {
            EmptyStateView(
                type: .noContactSearchResults(searchText: store.searchText),
                minHeight: geometry.size.height
            )
        }
    }
    
    @ViewBuilder
    private func errorView(_ geometry: GeometryProxy) -> some View {
        EmptyStateView(
            type: .noContactsAuthorization,
            minHeight: geometry.size.height) {
                send(.onOpenSettingsTap)
            }
    }
    
    @ViewBuilder
    private func loadedView() -> some View {
        EmptyView()
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
