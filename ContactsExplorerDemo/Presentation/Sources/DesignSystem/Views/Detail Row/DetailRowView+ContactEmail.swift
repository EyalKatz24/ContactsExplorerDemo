//
//  DetailRowView+ContactEmail.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import Models
import InternalUtilities

public extension DetailRowView {
    
    init(from email: Contact.Email) {
        self.title = email.label ?? .localized(.email)
        self.value = email.address
        self.imageSystemName = "envelope.fill"
    }
}

#Preview {
    DetailRowView(
        from: Contact.Email(
            label: "work",
            address: "my-work-email@example.com"
        )
    )
}
