//
//  AddDocumentView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/28/24.
//

import SwiftUI
import SwiftData

struct AddDocumentView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Query private var locations: [Location]
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var selectedLocation: Location?
    @State private var newLocationName: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("document-name", text: $name)
                Picker("document-select-location", selection: $selectedLocation) {
                    ForEach(locations, id: \.self) { location in
                        Text(location.name).tag(location as Location?)
                    }
                    Text("document-add-new-location").tag(nil as Location?)
                }
                if selectedLocation == nil {
                    TextField("document-new-location-name", text: $newLocationName)
                }
                TextField("document-description", text: $description, axis: .vertical)
            }
            .navigationTitle("add-document")
            .navigationBarItems(
                leading: Button("cancel") {
                    dismiss()
                },
                trailing: Button("add") {
                    addDocument()
                    dismiss()
                }
                .disabled(!canAddDocument)
            )
        }
    }
    
    private var canAddDocument: Bool {
        !name.isEmpty && (selectedLocation != nil || !newLocationName.isEmpty)
    }
    
    private func addDocument() {
        let locationName = selectedLocation?.name ?? newLocationName
        if selectedLocation == nil, !locationName.isEmpty {
            let newLocation = Location(name: locationName)
            context.insert(newLocation)
        }
        let newDocument = Document(name: name, location: locationName, documentDescription: description)
        context.insert(newDocument)
    }
}

#Preview {
    AddDocumentView()
}
