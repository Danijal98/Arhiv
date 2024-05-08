//
//  LocationsView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 5/2/24.
//

import SwiftUI
import SwiftData

struct LocationsView: View {
    @Environment(\.modelContext) private var context
    
    var goToDocumentsClicked: () -> Void
    
    @State private var showDeleteAlert: Bool = false
    @State private var indexSetToDelete: IndexSet = IndexSet()
    
    @State private var searchTerm: String = ""
    @Query private var locations: [Location]
    @Query private var documents: [Document]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(locations.filter {
                    searchTerm.isEmpty ? true :
                    $0.name.localizedCaseInsensitiveContains(searchTerm)
                }) { location in
                    NavigationLink(
                        destination: LocationView(
                            location: location,
                            goToDocumentsClicked: goToDocumentsClicked
                        )
                    ) {
                        Text(location.name)
                    }
                }
                .onDelete { indexSet in
                    self.indexSetToDelete = indexSet
                    self.showDeleteAlert = true
                }
            }
            .navigationTitle("locations-title")
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
            .alert("delete", isPresented: $showDeleteAlert, actions: {
                Button("no") {}
                Button("yes") {
                    deleteLocation(indexSet: indexSetToDelete)
                }
            }, message: {
                Text("location-alert-message")
            })
            .overlay {
                if locations.isEmpty {
                    ContentUnavailableView(label: {
                        Label("no-locations", systemImage: "list.bullet.rectangle.portrait")
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
    
    private func deleteLocation(indexSet: IndexSet) {
        for index in indexSet {
            let documentsToDelete = documents.filter { document in
                document.location == locations[index].name
            }
            for document in documentsToDelete {
                context.delete(document)
            }
            context.delete(locations[index])
        }
    }
}

#Preview {
    LocationsView(goToDocumentsClicked: {})
}
