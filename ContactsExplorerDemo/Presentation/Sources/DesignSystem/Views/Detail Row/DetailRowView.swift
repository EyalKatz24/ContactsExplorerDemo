//
//  DetailRowView.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

public struct DetailRowView: View {

    public let title: String
    public let value: String
    public let imageSystemName: String
    
    public init(title: String, value: String, imageSystemName: String) {
        self.title = title
        self.value = value
        self.imageSystemName = imageSystemName
    }
    
    public var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(.ultraThinMaterial)
                .overlay {
                    Image(systemName: imageSystemName)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.primary)
                        .padding(12)
                }
                .scaledMetricFrame(size: 44, maxSize: 56)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(value)
                    .font(.headline)
                    .foregroundStyle(.primary)
            }
            
            Spacer()
        }
    }
}

#Preview {
    DetailRowView(title: "Title", value: "Value", imageSystemName: "person")
        .padding()
}
