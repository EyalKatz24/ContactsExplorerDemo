//
//  Contact+Job.swift
//  Data
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation

public extension Contact {
 
    struct Job: Codable, Equatable, Hashable, Sendable {
        public let title: String
        public let departmentName: String?
        public let organizationName: String?
        
        public init(title: String, departmentName: String? = nil, organizationName: String? = nil) {
            self.title = title
            self.departmentName = departmentName
            self.organizationName = organizationName
        }
    }
}
