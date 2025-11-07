//
//  DetailRowView+PhoneNumber.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import Models

public extension DetailRowView {
    
    init(from phoneNumber: Contact.PhoneNumber) {
        self.title = phoneNumber.label.capitalized
        self.value = phoneNumber.number
        self.imageSystemName = phoneNumber.imageSystemName
    }
}

fileprivate extension Contact.PhoneNumber {
    
    var imageSystemName: String {
        switch labelType {
        case .main:
            "apple.logo"
        case .mobile:
            "iphone.gen3"
        case .other:
            "phone.fill"
        case .appleWatch:
            "applewatch"
        case .fax:
            "faxmachine.fill"
        case .pager:
            "widget.small"
        }
    }
}

#Preview {
    DetailRowView(
        from: Contact.PhoneNumber(
            label: "mobile",
            labelType: .mobile,
            number: "05487654321",
            isMain: false
        )
    )
}
