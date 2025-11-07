//
//  Contact+AverageColor.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI
import Models

public extension Contact {
    var averageColor: Color {
        guard let averageColor = Color(imageData: imageData) else { return .blue }
        return averageColor
    }
}
