//
//  Equatable+Extension.swift
//  Utilities
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation

public extension Equatable {
    
    func includedIn(_ items: Self...) -> Bool {
        items.contains(self)
    }
}
