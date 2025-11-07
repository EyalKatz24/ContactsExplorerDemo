//
//  ContactDetailsView+Details.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import ComposableArchitecture
import DesignSystem
import Models

extension ContactDetailsView {
    
    @ViewBuilder
    func detailsView() -> some View {
        VStack(spacing: 20) {
            DetailsSection(title: .phoneNumbers) {
                ForEach(store.contact.phoneNumbers, id: \.self) { phoneNumber in
                    DetailRowView(from: phoneNumber)
                        .padding(.top, 8)
                }
            }
            
            if let birthday = store.contact.birthday {
                DetailsSection(title: .birthday) {
                    DetailRowView(
                        title: .localized(.birthday),
                        value: birthday.formatted(date: .long, time: .omitted),
                        imageSystemName: "gift.fill"
                    )
                }
            }
            
            if let emails = store.contact.emails, !emails.filter({ $0.address.isNotEmpty }).isEmpty {
                DetailsSection(title: .emails) {
                    ForEach(emails, id: \.self) { email in
                        if email.address.isNotEmpty {
                            DetailRowView(from: email)
                                .padding(.top, 8)
                        }
                    }
                }
            }
        }
    }
}
