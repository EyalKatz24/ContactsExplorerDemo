//  
//  ContactsNavigator.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import ComposableArchitecture
import ContactsFeature

@Reducer
public struct ContactsNavigator {
    
    @ObservableState
    public struct State: Equatable {
        var root: ContactsStore.State
        var path = StackState<Path.State>()
        
        @Presents var destination: Destination.State?
        
        public init() {
            self.root = .init()
        }
    }
    
    public enum Action {
        case root(ContactsStore.Action)
        case path(StackAction<Path.State, Path.Action>)
        case destination(PresentationAction<Destination.Action>)
    }
    
    public init() { }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.root, action: \.root, child: ContactsStore.init)
        
        Reduce { state, action in
            switch action {
            case .root, .path, .destination:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
        .ifLet(\.$destination, action: \.destination)
    }
}

extension ContactsNavigator {
    
    @Reducer(state: .equatable, action: .equatable)
    public enum Path {

    }
    
    @Reducer(state: .equatable)
    public enum Destination {
        
    }
}
