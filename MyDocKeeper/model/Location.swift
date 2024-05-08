//
//  Location.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/28/24.
//

import Foundation
import SwiftData

@Model
class Location {
    var name: String
    @Relationship(deleteRule: .cascade, inverse: \Document.location)
    var documents = [Document]()
    
    init(name: String) {
        self.name = name
    }
}
