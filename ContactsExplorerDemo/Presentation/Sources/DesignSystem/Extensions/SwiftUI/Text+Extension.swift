//
//  Text+Extension.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import InternalUtilities

public extension Text {
    
    init(_ localization: Localization) {
        self.init(localization.localized)
    }
}
