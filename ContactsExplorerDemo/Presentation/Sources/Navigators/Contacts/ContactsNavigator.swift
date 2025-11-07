//  
//  ContactsNavigator.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import ComposableArchitecture
import InternalUtilities
import ContactsFeature
import ContactDetailsFeature

@Reducer
public struct ContactsNavigator {
    
    @ObservableState
    public struct State {
        var root: ContactsStore.State
        var path = StackState<Path.State>()
        
        public init() {
            self.root = .init()
        }
    }
    
    public enum Action {
        case root(ContactsStore.Action)
        case path(StackAction<Path.State, Path.Action>)
        case onContactsChange
        case notifyPathContactChange
    }
    
    public init() { }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.root, action: \.root, child: ContactsStore.init)
        
        Reduce { state, action in
            switch action {
            case let .root(.navigation(action)):
                return reduceContactsNavigationAction(&state, action)
                
            case .onContactsChange:
                return .merge(
                    reduce(into: &state, action: .root(.onContactsChange)),
                    .send(.notifyPathContactChange)
                )
                
            case .notifyPathContactChange:
                guard let elementId = state.path.elementId(ofCase: \.contactDetails) else { return .none }
                return state.path[case: \.contactDetails]?.onContactsChange()
                    .map { Action.path(.element(id: elementId, action: .contactDetails($0))) } ?? .none
                
            case .root, .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
    
    private func reduceContactsNavigationAction(_ state: inout State, _ action: ContactsStore.Action.Navigation) -> Effect<Action> {
        switch action {
        case let .onContactTap(contact):
            state.path.append(.contactDetails(ContactDetailsStore.State(contact: contact)))
            return .none
        }
    }
}

extension ContactsNavigator {
    
    @Reducer
    public enum Path {
        case contactDetails(ContactDetailsStore)
    }
}

