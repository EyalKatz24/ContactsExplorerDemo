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
            case onAppear
        }
        
        @CasePathable
        public enum Navigation: Equatable {
            
        }
        
        case view(View)
        case navigation(Navigation)
    }
    
    @Dependency(\.interactor) private var interactor
    
    public init() { }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                return reduceViewAction(&state, action)
                
            case .navigation:
                return .none
            }
        }
    }
    
    private func reduceViewAction(_ state: inout State, _ action: Action.View) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
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
