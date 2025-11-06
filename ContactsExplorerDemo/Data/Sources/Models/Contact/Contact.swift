//
//  Contact.swift
//  Data
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Utilities

public struct Contact: Codable, Identifiable {
    public let id: String
    public let imageData: Data?
    public let firstName: String
    public let lastName: String
    public let phoneNumbers: [PhoneNumber]
    public let job: Job?
    public let emails: [Email]?
    public let birthday: Date?
    
    public init(id: String, imageData: Data? = nil, firstName: String, lastName: String, phoneNumbers: [PhoneNumber], job: Job? = nil, emails: [Email]? = nil, birthday: Date? = nil) {
        self.id = id
        self.imageData = imageData
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumbers = phoneNumbers
        self.job = job
        self.emails = emails
        self.birthday = birthday
    }
    
    public var fullName: String? {
        let fullName = [firstName, lastName]
            .filter { $0.isNotEmpty }
            .joined(separator: .whitespace)
            .trimmed
        
        return fullName.isEmpty ? nil : fullName
    }
    
    public var initials: String {
        let splitName = (firstName.trimAlphanumerics + .whitespace + lastName.trimAlphanumerics).split(separator: .whitespace).prefix(2)
        var initials: String = .empty
        for word in splitName where !word.isEmpty {
            initials.append(String(word.first ?? .whitespace))
        }
        return initials
    }
    
    public var mainPhoneNumber: String {
        phoneNumbers.first { $0.isMain }?.number ?? phoneNumbers.first?.number ?? .empty
    }
}
