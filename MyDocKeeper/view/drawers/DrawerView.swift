//
//  DrawerView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/28/24.
//

import SwiftUI
import SwiftData

struct DrawerView: View {
    var drawer: Drawer
    @Query private var documents: [Document]
    
    var body: some View {
        List(documents.filter { $0.drawer == drawer.name }) { document in
            NavigationLink(destination: DocumentView(document: document)) {
                Text(document.name)
            }
            .navigationTitle(drawer.name)
        }
    }
}

#Preview {
    DrawerView(
        drawer: Drawer(name: "Drawer")
    )
}
