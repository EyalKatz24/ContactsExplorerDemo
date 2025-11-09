//
//  String+Extension.swift
//  Utilities
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation

public extension String {
    
    static let whitespace = "\u{0020}"
    static let empty = ""
    
    var isNotEmpty: Bool { !isEmpty }
    
    var trimmed: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimAlphanumerics: Self {
        trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    }
    
    static func randomString(in range: Range<Int>) -> Self {
        let base = "abcdefghijklmnopqrstuvwxyz"
        let randomCount = Int.random(in: range)
        var randomString: String = ""
        
        for _ in 0..<randomCount {
            let randomCharacter = base.randomElement() ?? "a"
            randomString.append(randomCharacter)
        }
        
        return randomString
    }
}
