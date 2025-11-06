//
//  SharedKey+Extension.swift
//  Data
//
//  Created by Eyal Katz on 06/11/2025.
//

import Foundation
import Sharing
import IdentifiedCollections
import Utilities

// MARK: - InMemory

public extension SharedKey where Self == InMemoryKey<[Contact]> {
    
    static var allContacts: Self { .inMemory(#function) }
}

// MARK: - FileStorage

public extension SharedKey where Self == FileStorageKey<IdentifiedArrayOf<Contact>> {
    
    static var favoriteContacts: Self { .fileStorage(.applicationDirectory.appending(path: #function).appendingPathExtension("json")) }
}
