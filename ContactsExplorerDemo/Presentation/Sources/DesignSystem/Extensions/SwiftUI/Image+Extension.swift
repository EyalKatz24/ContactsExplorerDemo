//
//  Image+Extension.swift
//  Presentation
//
//  Created by Eyal Katz on 06/11/2025.
//

import SwiftUI

public extension Image {
    
    init(data: Data?, placeholder: Image) {
        if let data, let uiImage = UIImage(data: data) {
            self.init(uiImage: uiImage)
        } else {
            self = placeholder
        }
    }
}
