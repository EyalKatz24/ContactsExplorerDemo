//
//  ContactItemShimmer.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import VeryLazy
import Utilities

public struct ContactItemShimmer: View {

    public init() { }
    
    public var body: some View {
        HStack {
            Shimmer(shape: .circle)
                .scaledMetricFrame(
                    size: DesignSystem.ImageSize.smallContactImage,
                    maxSize: DesignSystem.ImageSize.smallContactImageMaxSize
                )
            
            VStack(alignment: .leading) {
                Text(String.randomString(in: 10..<30))
                    .font(.body)
                    .fontWeight(.medium)
                    .redacted(reason: .placeholder)
                    .overlay {
                        Shimmer(shape: .rect(cornerRadius: 4))
                    }
                
                Text(String.randomString(in: 13..<20))
                    .font(.caption)
                    .fontWeight(.regular)
                    .redacted(reason: .placeholder)
                    .overlay {
                        Shimmer(shape: .rect(cornerRadius: 4))
                    }
            }
            
            Spacer()
        }
        .lineLimit(1)
        .dynamicTypeSize(...DynamicTypeSize.accessibility3)
        .padding(6)
        .contentShape(.rect)
    }
}

#Preview {
    ContactItemShimmer()
}
