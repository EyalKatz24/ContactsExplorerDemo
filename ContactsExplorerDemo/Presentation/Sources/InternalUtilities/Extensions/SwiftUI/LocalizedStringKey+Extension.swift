//
//  LocalizedStringKey+Extension.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

public extension LocalizedStringKey {
    
    static func localized(_ text: Localization) -> Self {
        .init(text.localized)
    }
}
