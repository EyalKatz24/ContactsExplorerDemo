//
//  ContactItemShimmer.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import VeryLazy

public struct ContactItemShimmer: View {

    public init() { }
    
    public var body: some View {
        HStack {
            Shimmer(shape: .circle)
                .scaledMetricFrame(
                    size: DesignSystem.ImageSize.smallContactImage,
                    maxSize: DesignSystem.ImageSize.smallContactImageMaxSize
                )

            GeometryReader { geometry in
                VStack(alignment: .leading, spacing: 6) {
                    Shimmer(shape: .rect(cornerRadius: 4))
                        .scaledMetricHeight(16)
                        .frame(width: geometry.size.width * CGFloat.random(in: 0.35...0.6))
                        .padding(.top, 3)
                    
                    Shimmer(shape: .rect(cornerRadius: 4))
                        .scaledMetricHeight(12)
                        .frame(width: geometry.size.width * CGFloat.random(in: 0.25...0.3))
                }
            }
            
            Spacer()
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(6)
        .contentShape(.rect)
    }
}

#Preview {
    ContactItemShimmer()
}
