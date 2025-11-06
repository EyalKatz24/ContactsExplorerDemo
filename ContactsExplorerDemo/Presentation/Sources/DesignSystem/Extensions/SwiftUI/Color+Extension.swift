//
//  Color+Extension.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

extension Color {
    
    init?(imageData: Data?) {
        guard let data = imageData,
              let uiImage = UIImage(data: data),
              let averageUIColor = uiImage.averageColor else {
            return nil
        }
        self = Color(averageUIColor)
    }
}
