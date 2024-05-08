//
//  UpdateDocumentView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/29/24.
//

import SwiftUI
import SwiftData

struct UpdateDocumentView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var document: Document
    
    @State private var oldDocumentName: String = ""
    @State private var oldDocumentLocation: String = ""
    @State private var oldDocumentDescription: String = ""
    
    @Query private var locations: [Location]
    @State private var selectedLocation: Location?
    @State private var newLocationName: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("document-name", text: $document.name)
                Picker("document-select-location", selection: $selectedLocation) {
                    ForEach(locations, id: \.self) { location in
                        Text(location.name).tag(location as Location?)
                    }
                    Text("document-add-new-location").tag(nil as Location?)
                }
                if selectedLocation == nil {
                    TextField("document-new-location-name", text: $newLocationName)
                }
                
                TextField("document-description", text: $document.documentDescription, axis: .vertical)
            }
            .navigationTitle("add-document")
            .navigationBarItems(
                leading: Button("cancel") {
                    revertDocument()
                    dismiss()
                },
                trailing: Button("done") {
                    addLocation()
                    dismiss()
                }
                    .disabled(!canUpdateDocument)
            )
            .onAppear {
                selectedLocation = locations.first { $0.name == document.location }
                
                oldDocumentName = document.name
                oldDocumentLocation = document.location
                oldDocumentDescription = document.documentDescription
            }
        }
    }
    
    private var canUpdateDocument: Bool {
        !document.name.isEmpty && (selectedLocation != nil || !newLocationName.isEmpty)
    }
    
    private func addLocation() {
        let locationName = selectedLocation?.name ?? newLocationName
        if selectedLocation == nil, !locationName.isEmpty {
            let newLocation = Location(name: locationName)
            document.location = newLocation.name
            context.insert(newLocation)
        } else if selectedLocation != nil {
            document.location = selectedLocation!.name
        }
    }
    
    private func revertDocument() {
        document.name = oldDocumentName
        document.location = oldDocumentLocation
        document.documentDescription = oldDocumentDescription
    }
}

#Preview {
    UpdateDocumentView(document: Document(name: "Document", location: "Location", documentDescription: "Description"))
}
