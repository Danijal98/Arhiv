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
    @Attribute(.unique) var name: String
    
    init(name: String) {
        self.name = name
    }
}
