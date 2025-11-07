//
//  DesignSystem.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation

public enum DesignSystem {
    
    public enum ImageSize {
        static let smallContactImage: CGFloat = 36
        static let smallContactImageMaxSize: CGFloat = 48
        static let fixedLargeContactImage: CGFloat = 140
    }
    
    public enum CornerRadius {
        static var grouping: CGFloat {
            guard #available(iOS 26.0, *) else { return 8 }
            return 16
        }
    }
}
