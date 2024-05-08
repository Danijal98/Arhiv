//
//  ContentView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/28/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            DocumentsView()
                .tabItem {
                    Label("documents-title", systemImage: "list.bullet.clipboard")
                }
                .tag(0)
            
            LocationsView(
                goToDocumentsClicked: {
                    selection = 0
                }
            )
            .tabItem {
                Label("locations-title", systemImage: "safari")
            }
            .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("settings-title", systemImage: "gear")
                }
                .tag(2)
        }
    }
}

#Preview {
    MainView()
}
