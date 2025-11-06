//
//  Contact+Email.swift
//  Data
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation

public extension Contact {

    struct Email: Codable, Equatable, Hashable, Sendable {
        public let label: String?
        public let address: String
        
        public init(label: String?, address: String) {
            self.label = label
            self.address = address
        }
    }
}
