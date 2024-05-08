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
                selectedLocation = locations.first { $0 == document.location }
                
                oldDocumentName = document.name
                oldDocumentLocation = document.location?.name ?? ""
                oldDocumentDescription = document.documentDescription
            }
        }
    }
    
    private var canUpdateDocument: Bool {
        !document.name.isEmpty && (selectedLocation != nil || !newLocationName.isEmpty)
    }
    
    private func addLocation() {
        let fallbackLocation = locations.first(where: { $0.name == newLocationName }) ?? Location(name: newLocationName)
        let location = selectedLocation ?? fallbackLocation
        
        document.location = location
    }
    
    private func revertDocument() {
        document.name = oldDocumentName
        document.location?.name = oldDocumentLocation
        document.documentDescription = oldDocumentDescription
    }
}

#Preview {
    UpdateDocumentView(document: Document(name: "Document", location: Location(name: "Location"), documentDescription: "Description"))
}
