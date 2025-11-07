//
//  DetailsSection.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import InternalUtilities

public struct DetailsSection<Content>: View where Content: View {
    
    public let title: Localization
    @ViewBuilder public var content: () -> Content
    
    public init(title: Localization, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(.localized(title))
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(.primary)
                .padding(.bottom, 8)
            
            content()
        }
        .leadingAligned()
        .padding()
        .grouped()
    }
}

#Preview {
    DetailsSection(title: .birthday) {
        
    }
}
