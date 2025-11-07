//  
//  ContactsStore.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import ComposableArchitecture
import Models
import InternalUtilities

@Reducer
public struct ContactsStore {
    
    @ObservableState
    public struct State: Equatable {
        
        @Shared(.favoriteContacts)
        var favoriteContacts: IdentifiedArrayOf<Contact> = []
        var viewState: ViewState
        var searchText: String = .empty
        var contacts: [Contact]
        
        public init() {
            @Dependency(\.interactor) var interactor
            self.contacts = interactor.allContacts
            
            self.viewState = switch interactor.contactsAuthorization {
            case .permitted, .notDetermined: .loading
            case .notPermitted: .error(.contactsAuthorizationDenied)
            }
        }
    }
    
    public enum Action: ViewAction, Equatable {
        public enum View: Equatable {
            case onFirstAppear
            case onContactTap(Contact)
            case onContactActionTap(Contact, ContactAction)
            case onRetryButtonTap
            case onOpenSettingsTap
        }
        
        public enum Navigation: Equatable {
            case onContactTap(Contact)
        }
        
        case view(View)
        case navigation(Navigation)
        case onContactsChange
        case checkContactsAuthorization
        case requestContactsAuthorization
        case onContactsAuthorizationResult(Bool)
        case retrieveContacts
        case onRetrieveContactsResult(Result<[Contact], ContactsError>)
        case displayAllContacts
        case onContactsError(ContactsError)
        case onSearchTextChange(String)
        case setFilteredContacts([Contact])
        case toggleContactFavoriteStatus(Contact)
    }
    
    @Dependency(\.interactor) private var interactor
    
    public init() { }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                return reduceViewAction(&state, action)
                
            case .onContactsChange:
                state.contacts = interactor.allContacts
                state.searchText = .empty
                return .none
                
            case .checkContactsAuthorization:
                switch interactor.contactsAuthorization {
                case .permitted:
                    return .run { send in
                        guard await interactor.didRetrieveContacts() else {
                            await send(.retrieveContacts)
                            return
                        }
                        
                        await send(.displayAllContacts)
                    }
                    
                case .notPermitted:
                    state.viewState = .error(.contactsAuthorizationDenied)
                    return .none
                    
                case .notDetermined:
                    return .send(.requestContactsAuthorization)
                }
                
            case .requestContactsAuthorization:
                return .run { send in
                    let authorized = await interactor.requestContactsAuthorization()
                    await send(.onContactsAuthorizationResult(authorized))
                }
                
            case let .onContactsAuthorizationResult(authorized):
                guard authorized else {
                    return .send(.onContactsError(.contactsAuthorizationDenied))
                }
                return .send(.retrieveContacts)
                
            case .retrieveContacts:
                return .run { send in
                    let result = await interactor.retrieveContacts()
                    await send(.onRetrieveContactsResult(result))
                }
                .debounce(for: .shimmer)

            case let .onRetrieveContactsResult(result):
                switch result {
                case .success:
                    return .send(.displayAllContacts)
                    
                case let .failure(error):
                    return .send(.onContactsError(error))
                }
                
            case .displayAllContacts:
                state.contacts = interactor.allContacts
                state.viewState = .loaded
                return .none
                
            case let .onContactsError(contactsError):
                state.viewState = .error(contactsError)
                return .none
                
            case let .onSearchTextChange(searchValue):
                state.searchText = searchValue

                guard searchValue.isNotEmpty else {
                    state.contacts = interactor.allContacts
                    return .none
                }
        
                let searchText = state.searchText
                return .concatenate(
                    .cancel(id: CancelID.contactsFilter),
                    .run(priority: .userInitiated) { send in
                        let filteredContacts = await interactor.filterContacts(using: searchValue)

                        if searchValue == searchText {
                            await send(.setFilteredContacts(filteredContacts))
                        }
                    }
                    .cancellable(id: CancelID.contactsFilter, cancelInFlight: true)
                )
                
            case let .setFilteredContacts(filteredContacts):
                state.contacts = filteredContacts
                return .none
                
            case let .toggleContactFavoriteStatus(contact):
                return .run { send in
                    await interactor.toggleContactFavoriteStatus(contact)
                }
                
            case .navigation:
                return .none
            }
        }
    }
    
    private func reduceViewAction(_ state: inout State, _ action: Action.View) -> Effect<Action> {
        switch action {
        case .onFirstAppear:
            switch state.viewState {
            case .loading:
                return .send(.checkContactsAuthorization, after: 0.2)
                
            case .loaded:
                return .none
                
            case .error:
                return .none
            }
            
        case let .onContactTap(contact):
            return .send(.navigation(.onContactTap(contact)))
            
        case let .onContactActionTap(contact, action):
            return reduceContactActionTap(action, for: contact)
            
        case .onRetryButtonTap:
            state.viewState = .loading
            return .send(.retrieveContacts)
            
        case .onOpenSettingsTap:
            return .run { _ in
                await interactor.openAppSettings()
            }
        }
    }
    
    private func reduceContactActionTap(_ contactAction: ContactAction, for contact: Contact) -> Effect<Action> {
        switch contactAction {
        case .favoriteToggle:
            return .send(.toggleContactFavoriteStatus(contact))
            
        case .message:
            return .none
        }
    }
}

extension ContactsStore {
    enum ViewState: Equatable {
        case loading
        case loaded
        case error(ContactsError)
    }
    
    fileprivate enum CancelID {
        case contactsFilter
    }
}

extension DependencyValues {
    fileprivate var interactor: ContactsInteractor {
        get { self[ContactsInteractor.self] }
    }
}
