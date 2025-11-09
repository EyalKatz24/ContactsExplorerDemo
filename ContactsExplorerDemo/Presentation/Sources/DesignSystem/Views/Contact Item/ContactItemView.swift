//
//  ContactItemView.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import Models

public struct ContactItemView: View {
    
    public let contact: Contact
    public let highlightedText: String?
    
    public init(contact: Contact, highlightedText: String?) {
        self.contact = contact
        self.highlightedText = highlightedText
    }
    
    private var contactName: AttributedString {
        var result = AttributedString(contact.fullName ?? .empty)
        
        if let highlightedText, let range = result.range(of: highlightedText, options: .caseInsensitive) {
            result.foregroundColor = .primary.opacity(0.6)
            result[range].foregroundColor = .primary
        } else {
            result.foregroundColor = .primary
        }
        
        return result
    }
    
    private var phoneNumber: AttributedString {
        var result = AttributedString(contact.mainPhoneNumber)
        
        if let highlightedText, let range = result.range(of: highlightedText, options: .caseInsensitive) {
            result.foregroundColor = .primary.opacity(0.6)
            result[range].foregroundColor = .primary
        } else {
            result.foregroundColor = .primary
        }
        
        return result
    }
    
    private var otherPhoneNumber: AttributedString? {
        guard let otherNumber = contact.phoneNumbers
            .filter({ $0.number != contact.mainPhoneNumber && $0.number.replacingOccurrences(of: "-", with: "").contains(highlightedText ?? .empty) }).first else { return nil }
        
        var result = AttributedString("(\(otherNumber.label): \(otherNumber.number))")
        
        if let highlightedText, let range = result.range(of: highlightedText, options: .caseInsensitive) {
            result.foregroundColor = .primary.opacity(0.6)
            result[range].foregroundColor = .primary
        } else {
            result.foregroundColor = .primary
        }
        
        return result
    }
    
    public var body: some View {
        HStack {
            ContactImage(
                contact: contact,
                size: .small
            )

            VStack(alignment: .leading) {
                Text(contactName)
                    .font(.body)
                    .fontWeight(.medium)
                    .lineLimit(2)
                
                HStack(spacing: 16) {
                    Text(phoneNumber)
                        .font(.caption)
                        .fontWeight(.regular)
                        .foregroundStyle(.primary)
                        .lineLimit(1)
                    
                    if highlightedText != nil, highlightedText?.isNotEmpty == true, contact.phoneNumbers.count > 1, let otherPhoneNumber {
                        Text(otherPhoneNumber)
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundStyle(.primary)
                            .lineLimit(1)
                    }
                }
            }
            
            Spacer()
        }
        .dynamicTypeSize(...DynamicTypeSize.accessibility3)
        .padding(6)
        .contentShape(.rect)
    }
}

#Preview {
    ContactItemView(
        contact: Contact(
            id: UUID().uuidString,
            imageData: nil,
            firstName: "John",
            lastName: "Appleseed",
            phoneNumbers: [.init(label: "mobile", labelType: .mobile, number: "888-555-1212")],
            emails: [.init(label: "work", address: "john.appleseed@example.com")],
            birthday: Date()
        ),
        highlightedText: nil
    )
}
