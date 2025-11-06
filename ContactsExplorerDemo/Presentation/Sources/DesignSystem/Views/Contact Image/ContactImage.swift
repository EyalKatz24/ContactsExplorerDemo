//
//  ContactImage.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import Models

public struct ContactImage: View {
    
    public let contact: Contact
    public let size: Size
    
    public init(contact: Contact, size: Size) {
        self.contact = contact
        self.size = size
    }
    
    public var body: some View {
        Group {
            if let imageData = contact.imageData, !imageData.isEmpty {
                contactImage(with: imageData)
                
            } else {
                initialsView()
            }
        }
        .modify { view in
            switch size {
            case .small:
                view
                    .scaledMetricFrame(size: 36, maxSize: 48)
                
            case .fixedLarge:
                view
                    .frame(width: 140, height: 140)
            }
        }
    }
    
    @ViewBuilder
    private func contactImage(with data: Data) -> some View {
        Image(
            data: data,
            placeholder: Image(systemName: "person.crop.circle.fill")
        )
        .resizable()
        .scaledToFill()
        .clipShape(.circle)
        .glassEffectWrapper()
    }
    
    @ViewBuilder
    private func initialsView() -> some View {
        if #available(iOS 26.0, *) {
            Text(contact.initials.uppercased())
                .font(size.initialsFont)
                .fontWeight(.medium)
                .tint(.primary)
                .foregroundStyle(.primary) // TODO: dynamic size limit
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassEffect(in: .circle)
                
        } else {
            Circle()
                .fill(.ultraThinMaterial)
                .overlay {
                    Text(contact.initials.uppercased())
                        .font(size.initialsFont)
                        .fontWeight(.medium)
                        .tint(.primary)
                        .foregroundStyle(.primary) // TODO: dynamic size limit
                }
        }
    }
}

#Preview {
    let contact = Contact(
        id: UUID().uuidString,
        imageData: nil,
        firstName: "John",
        lastName: "Appleseed",
        phoneNumbers: [.init(label: "mobile", labelType: .mobile, number: "888-555-1212")],
        emails: [.init(label: "work", address: "john.appleseed@example.com")],
        birthday: Date()
    )
    
    ContactImage(
        contact: contact,
        size: .small
    )
    
    ContactImage(
        contact: contact,
        size: .fixedLarge
    )
}
