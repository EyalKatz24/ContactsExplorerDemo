//
//  Contact+PhoneNumber.swift
//  Data
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation

public extension Contact {
    
    struct PhoneNumber: Codable, Equatable, Hashable, Sendable {
        public let label: String
        public let labelType: LabelType
        public let number: String
        public let isMain: Bool
        
        public init(label: String, labelType: LabelType, number: String, isMain: Bool = true) {
            self.label = label
            self.labelType = labelType
            self.number = number
            self.isMain = isMain
        }
    }
}

public extension Contact.PhoneNumber {
    
    enum LabelType: String, Codable, CaseIterable, Sendable {
        case appleWatch
        case mobile
        case main
        case fax
        case pager
        case other
    }
}
