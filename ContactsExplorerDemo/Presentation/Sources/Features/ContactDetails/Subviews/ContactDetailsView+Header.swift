//
//  ContactDetailsView+Header.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import DesignSystem
import Models

extension ContactDetailsView {
    
    @ViewBuilder
    func header() -> some View {
        VStack(spacing: 0) {
            if let job = store.contact.job {
                Text(job.title)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
            
            if let fullName = store.contact.fullName {
                Text(fullName)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
            }
        }
    }
}
