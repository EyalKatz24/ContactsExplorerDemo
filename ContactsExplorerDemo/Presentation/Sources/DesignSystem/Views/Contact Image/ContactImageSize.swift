//
//  ContactImageSize.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

public extension ContactImage {
    
    enum Size {
        case small
        case fixedLarge
        
        var initialsFont: Font {
            switch self {
            case .small:
                .callout
            case .fixedLarge:
                .system(size: 60)
            }
        }
        
        var initialsGlassEffectPadding: CGFloat {
            switch self {
            case .small:
                0
            case .fixedLarge:
                12
            }
        }
    }
}
