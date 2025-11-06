//
//  ContactDetailsView+LabelButton.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import DesignSystem
import Models

extension ContactDetailsView {
    
    @ViewBuilder
    func labelButton() -> some View {
        Button {
            send(.onContactFavoriteStatusTap)
        } label: {
            HStack {
                Text(store.contact.isFavorite ? .markAsFavorite : .markedAsFavorite)
                    .font(.body)
                    .fontWeight(.heavy)
                    .foregroundStyle(.primary)
                    .tint(.primary)
                    .contentTransition(.numericText())
                
                Image(systemName: store.contact.isFavorite ? "star.fill" : "star")
                    .foregroundStyle(.yellow)
                    .font(.title2)
                    .contentTransition(.symbolEffect(.replace.offUp, options: .speed(0.7)))
            }
        }
        .buttonStyle(.label)
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.9), trigger: store.contact.isFavorite)
    }
}
