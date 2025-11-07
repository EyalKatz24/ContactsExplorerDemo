//  
//  AppNavigator.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import ComposableArchitecture
import Models
import ContactsNavigator

@Reducer
public struct AppNavigator {
    
    @ObservableState
    public struct State {
        var root: ContactsNavigator.State
        
        public init() {
            self.root = .init()
        }
    }
    
    public enum Action: ViewAction {
        public enum View {
            case onFirstAppear
            case appLifeCycle(AppLifeCycle)
            
            public enum AppLifeCycle {
                case onContactsChange
            }
        }
        
        case view(View)
        case root(ContactsNavigator.Action)
        case onRetrieveContactsResult(Result<[Contact], ContactsError>)
        case onUpdatedContactsRetrieval
    }
    
    @Dependency(\.interactor) private var interactor
    
    public init() { }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.root, action: \.root, child: ContactsNavigator.init)
        
        Reduce { state, action in
            switch action {
            case let .view(action):
                return reduceViewAction(&state, action)
                
            case let .onRetrieveContactsResult(result):
                switch result {
                case .success:
                    return .send(.onUpdatedContactsRetrieval)
                    
                case .failure:
                    return .none
                }
                
            case .onUpdatedContactsRetrieval:
                return reduce(into: &state, action: .root(.onContactsChange))
                
            case .root:
                return .none
            }
        }
    }
    
    // MARK: - View Acions
    
    private func reduceViewAction(_ state: inout State, _ action: Action.View) -> Effect<Action> {
        switch action {
        case .onFirstAppear:
            // A placeholder action for optional future app initiation actions
            return .none
            
        case let .appLifeCycle(action):
            return reduceLifeCycleAction(&state, action)
        }
    }
    
    // MARK: - Life Cycle Actions
    
    private func reduceLifeCycleAction(_ state: inout State, _ action: Action.View.AppLifeCycle) -> Effect<Action> {
        switch action {
        case .onContactsChange:
            return .run { send in
                let result = await interactor.retrieveAllContacts()
                await send(.onRetrieveContactsResult(result))
            }
        }
    }
}

extension DependencyValues {
    fileprivate var interactor: AppNavigatorInteractor {
        get { self[AppNavigatorInteractor.self] }
    }
}
