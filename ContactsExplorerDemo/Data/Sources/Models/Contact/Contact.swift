//
//  Contact.swift
//  Data
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Utilities

public struct Contact: Codable, Identifiable {
    public var id: UUID
    public var name: String
    public var email: String
    public var phone: String
    public var address: String
    public var notes: String?
    
    public init(id: UUID = UUID(), name: String, email: String, phone: String, address: String, notes: String? = nil) {
        
    }
}
