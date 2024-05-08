//
//  LocationView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/28/24.
//

import SwiftUI
import SwiftData

struct LocationView: View {
    var location: Location
    var goToDocumentsClicked: () -> Void
    
    @State private var showEdit = false
    @Query private var documents: [Document]
    
    var body: some View {
        let locationDocuments = documents.filter { $0.location == location.name }
        
        List(locationDocuments) { document in
            NavigationLink(destination: DocumentView(document: document)) {
                Text(document.name)
            }
        }
        .navigationTitle(location.name)
        .navigationBarItems(trailing: Button(action: {
            showEdit = true
        }) {
            Text("edit")
        })
        .sheet(isPresented: $showEdit) {
            UpdateLocationView(location: location)
        }
        .overlay {
            if locationDocuments.isEmpty {
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
    LocationView(
        location: Location(name: "Location"),
        goToDocumentsClicked: {}
    )
}
