//  
//  ContactDetailsStore.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import ComposableArchitecture
import Models

@Reducer
public struct ContactDetailsStore {
    
    @ObservableState
    public struct State: Equatable {
        public var contact: Contact
        
        public init(contact: Contact) {
            self.contact = contact
        }
        
        public func onContactsChange() -> Effect<Action> {
            .send(.onContactsChange)
        }
    }
    
    public enum Action: ViewAction, Equatable {
        @CasePathable
        public enum View: Equatable {
            case onFirstAppear
            case onContactFavoriteStatusTap
        }
        
        case view(View)
        case onContactsChange
        case toggleContactFavoriteStatus
    }
    
    @Dependency(\.interactor) private var interactor
    
    public init() { }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .view(action):
                return reduceViewAction(&state, action)
                
            case .onContactsChange:
                if let contact = interactor.getUpdatedData(for: state.contact) {
                    state.contact = contact
                }
                return .none
                
            case .toggleContactFavoriteStatus:
                let contact = state.contact
                return .run { send in
                    await interactor.toggleContactFavoriteStatus(contact)
                }
            }
        }
    }
    
    private func reduceViewAction(_ state: inout State, _ action: Action.View) -> Effect<Action> {
        switch action {
        case .onFirstAppear:
            return .none
            
        case .onContactFavoriteStatusTap:
            return .send(.toggleContactFavoriteStatus)
        }
    }
}

extension DependencyValues {
    fileprivate var interactor: ContactDetailsInteractor {
        get { self[ContactDetailsInteractor.self] }
    }
}
