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
    var goToDocumentsClicked: () -> Void
    
    @Query private var documents: [Document]
    
    var body: some View {
        let drawerDocuments = documents.filter { $0.drawer == drawer.name }
        
        List(drawerDocuments) { document in
            NavigationLink(destination: DocumentView(document: document)) {
                Text(document.name)
            }
        }
        .navigationTitle(drawer.name)
        .overlay {
            if drawerDocuments.isEmpty {
                ContentUnavailableView(label: {
                    Label("no-documents", systemImage: "list.bullet.rectangle.portrait")
                }, description: {
                    Text("no-documents-text")
                }, actions: {
                    Button("go-to-documents") {
                        goToDocumentsClicked()
                    }
                })
                .offset(y: -60)
            }
        }
    }
}

#Preview {
    DrawerView(
        drawer: Drawer(name: "Drawer"),
        goToDocumentsClicked: {}
    )
}
