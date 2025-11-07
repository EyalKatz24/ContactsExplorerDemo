//
//  String+Extension.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation

public extension String {
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    static func localized(_ text: Localization) -> Self {
        text.localized
    }
}
