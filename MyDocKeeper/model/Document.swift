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
    var location: Location?
    var documentDescription: String
    
    init(name: String, location: Location, documentDescription: String) {
        self.name = name
        self.location = location
        self.documentDescription = documentDescription
    }
}
