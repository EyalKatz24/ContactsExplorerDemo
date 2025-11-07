//  
//  ContactsView.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import ComposableArchitecture
import Models
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
                        
                    case let .error(contactsError):
                        errorView(for: contactsError, with: geometry)
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
        VStack(spacing: 0) {
            ForEach(0..<16, id: \.self) { _ in
                ContactItemShimmer()
            }
            
            Spacer()
        }
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
    private func errorView(for error: ContactsError, with geometry: GeometryProxy) -> some View {
        switch error {
        case .contactsAuthorizationDenied:
            EmptyStateView(
                type: .noContactsAuthorization,
                minHeight: geometry.size.height) {
                    send(.onOpenSettingsTap)
                }
            
        case .contactsDataAccessError:
            EmptyStateView(
                type: .contactsDataAccessError,
                minHeight: geometry.size.height
            )
            
        default:
            EmptyStateView(
                type: .contactsUnknownError,
                minHeight: geometry.size.height) {
                    send(.onRetryButtonTap)
                }
        }
    }
    
    @ViewBuilder
    private func loadedView() -> some View {
        ForEach(store.contacts) { contact in
            Button {
                send(.onContactTap(contact))
            } label: {
                ContactItemView(contact: contact, highlightedText: store.searchText)
            }
            .contextMenu {
                ForEach(contact.actions, id: \.self) { action in
                    Button {
                        send(.onContactActionTap(contact, action))
                    } label: {
                        Label(
                            .localized(action.title(isFavorite: contact.isFavorite)),
                            systemImage: action.imageSystemName(isFavorite: contact.isFavorite)
                        )
                    }
                    .disabled(!action.isEnabled)
                }
            }
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
