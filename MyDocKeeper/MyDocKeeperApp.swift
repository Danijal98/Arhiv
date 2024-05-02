//
//  MyDocKeeperApp.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/28/24.
//

import SwiftUI
import SwiftData

@main
struct MyDocKeeperApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [Document.self, Drawer.self])
    }
}
