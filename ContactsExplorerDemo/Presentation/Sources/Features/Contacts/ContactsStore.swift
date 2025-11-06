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
        var viewState: ViewState
        var searchText: String = .empty
        var contacts: [Contact]
        
        public init() {
            @Dependency(\.interactor) var interactor
            self.contacts = interactor.allContacts
            
            self.viewState = switch interactor.contactsAuthorization {
            case .permitted, .notDetermined: .loading
            case .notPermitted: .error
            }
        }
    }
    
    public enum Action: ViewAction, Equatable {
        @CasePathable
        public enum View: Equatable {
            case onFirstAppear
        }
        
        @CasePathable
        public enum Navigation: Equatable {
            
        }
        
        case view(View)
        case navigation(Navigation)
        case checkContactsAuthorization
        case requestContactsAuthorization
        case onContactsAuthorizationResult(Bool)
        case retrieveContacts
        case onRetrieveContactsResult
    }
    
    @Dependency(\.interactor) private var interactor
    
    public init() { }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                return reduceViewAction(&state, action)
                
            case .checkContactsAuthorization:
                switch interactor.contactsAuthorization {
                case .permitted:
                    return .run { send in
                        guard await interactor.didRetrieveContacts() else {
                            await send(.retrieveContacts)
                            return
                        }
                        
                        await send(.onRetrieveContactsResult)
                    }
                    
                case .notPermitted:
                    state.viewState = .error
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
                state.viewState = authorized ? .loaded : .error
                return .none
                
            case .retrieveContacts:
                return .run { send in
                    await interactor.retrieveContacts()
                    await send(.onRetrieveContactsResult)
                }

            case .onRetrieveContactsResult:
                state.contacts = interactor.allContacts
                state.viewState = .loaded
                return .none
                
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
                return .send(.checkContactsAuthorization, after: 0.5)
                
            case .loaded:
                return .none
                
            case .error:
                return .none
            }
        }
    }
}

extension ContactsStore {
    enum ViewState: Equatable {
        case loading
        case loaded
        case error
    }
}

extension DependencyValues {
    fileprivate var interactor: ContactsInteractor {
        get { self[ContactsInteractor.self] }
    }
}
