//
//  StackState+Extension.swift
//  Presentation
//
//  Created by Eyal Katz on 07/11/2025.
//

import ComposableArchitecture

public extension StackState {
    
    func elementId<Case>(ofCase path: CaseKeyPath<Element, Case>) -> StackElementID? where Element: CasePathable {
        ids.first(where: { self[id: $0, case: path] != nil })
    }
    
    subscript<Case>(case path: CaseKeyPath<Element, Case>) -> Case? where Element: CasePathable {
        guard let id = elementId(ofCase: path) else { return nil }
        return self[id: id, case: path]
    }
}
