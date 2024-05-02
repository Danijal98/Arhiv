//
//  Drawer.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/28/24.
//

import Foundation
import SwiftData

@Model
class Drawer {
    @Attribute(.unique) var name: String
    
    init(name: String) {
        self.name = name
    }
}
