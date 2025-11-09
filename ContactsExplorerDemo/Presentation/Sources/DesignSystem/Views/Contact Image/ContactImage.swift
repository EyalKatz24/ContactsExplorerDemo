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
        .overlay {
            if contact.isFavorite {
                favoriteMark()
                    .offset(x: 4, y: 2)
                    .transition(
                        .asymmetric(
                            insertion: .scale(scale: 0.5).combined(with: .opacity),
                            removal: .offset(y: 6).combined(with: .opacity).animation(.smooth(duration: 0.2).delay(0.3))
                        )
                    )
            }
        }
        .animation(.bouncy(duration: 0.3, extraBounce: 0.3).delay(0.3), value: contact.isFavorite)
        .modify { view in
            switch size {
            case .small:
                view
                    .scaledMetricFrame(
                        size: DesignSystem.ImageSize.smallContactImage,
                        maxSize: DesignSystem.ImageSize.smallContactImageMaxSize
                    )
                
            case .fixedLarge:
                view
                    .frame(
                        width: DesignSystem.ImageSize.fixedLargeContactImage,
                        height: DesignSystem.ImageSize.fixedLargeContactImage
                    )
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
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .glassEffect(in: .circle)
                .dynamicTypeSize(...DynamicTypeSize.xxLarge)
                
        } else {
            Circle()
                .fill(.ultraThinMaterial)
                .overlay {
                    Text(contact.initials.uppercased())
                        .font(size.initialsFont)
                        .fontWeight(.medium)
                        .tint(.primary)
                        .foregroundStyle(.primary)
                        .dynamicTypeSize(...DynamicTypeSize.xxLarge)
                }
        }
    }
    
    @ViewBuilder
    private func favoriteMark() -> some View {
        switch size {
        case .small:
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                    
                    Image(systemName: "star.fill")
                        .resizable()
                        .foregroundStyle(.yellow)
                        .scaledMetricFrame(
                            size: DesignSystem.ImageSize.smallContactImage / 2,
                            maxSize: DesignSystem.ImageSize.smallContactImageMaxSize / 2
                        )
                }
            }
        
        case .fixedLarge:
            EmptyView()
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
