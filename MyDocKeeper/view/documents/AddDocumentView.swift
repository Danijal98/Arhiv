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
    
    @Query private var drawers: [Drawer]
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var selectedDrawer: Drawer?
    @State private var newDrawerName: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("document-name", text: $name)
                Picker("document-select-drawer", selection: $selectedDrawer) {
                    ForEach(drawers, id: \.self) { drawer in
                        Text(drawer.name).tag(drawer as Drawer?)
                    }
                    Text("document-add-new-drawer").tag(nil as Drawer?)
                }
                if selectedDrawer == nil {
                    TextField("document-new-drawer-name", text: $newDrawerName)
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
        !name.isEmpty && (selectedDrawer != nil || !newDrawerName.isEmpty)
    }
    
    private func addDocument() {
        let drawerName = selectedDrawer?.name ?? newDrawerName
        if selectedDrawer == nil, !drawerName.isEmpty {
            let newDrawer = Drawer(name: drawerName)
            context.insert(newDrawer)
        }
        let newDocument = Document(name: name, drawer: drawerName, documentDescription: description)
        context.insert(newDocument)
    }
}

#Preview {
    AddDocumentView()
}
