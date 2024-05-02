//
//  Document.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/28/24.
//

import Foundation
import SwiftData

@Model
class Document {
    @Attribute(.unique) var name: String
    var drawer: String
    var documentDescription: String
    
    init(name: String, drawer: String, documentDescription: String) {
        self.name = name
        self.drawer = drawer
        self.documentDescription = documentDescription
    }
}
