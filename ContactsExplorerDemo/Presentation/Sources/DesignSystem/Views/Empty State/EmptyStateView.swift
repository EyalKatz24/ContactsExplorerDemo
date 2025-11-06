//
//  EmptyStateView.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

public struct EmptyStateView: View {
    
    public let type: EmptyState
    public var minHeight: CGFloat
    public var onButtonTap: (() -> Void)?
    
    public init(type: EmptyState, minHeight: CGFloat = 0, onButtonTap: (() -> Void)? = nil) {
        self.type = type
        self.minHeight = minHeight
        self.onButtonTap = onButtonTap
    }
    
    public var body: some View {
        VStack {
            Image(systemName: type.imageSystemName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.gray)
                .scaledMetricHeight(48, maxHeight: 64)
                .padding(.bottom, 12)
            
            Text(type.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            Text(type.message)
                .font(.subheadline)
                .fontWeight(.regular)
                .foregroundStyle(.secondary)
            
            if let buttonTitle = type.buttonTitle {
                Button {
                    onButtonTap?()
                } label: {
                    Text(buttonTitle)
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .buttonStyle(.capsule)
                .padding(.top, 16)
            }
        }
        .multilineTextAlignment(.center)
        .frame(minHeight: minHeight)
    }
}

#Preview {
    EmptyStateView(type: .noContactSearchResults(searchText: "test"))
}
