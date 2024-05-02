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
    
    @Query private var drawers: [Drawer]
    @State private var selectedDrawer: Drawer?
    @State private var newDrawerName: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("document-name", text: $document.name)
                Picker("document-select-drawer", selection: $selectedDrawer) {
                    ForEach(drawers, id: \.self) { drawer in
                        Text(drawer.name).tag(drawer as Drawer?)
                    }
                    Text("document-add-new-drawer").tag(nil as Drawer?)
                }
                if selectedDrawer == nil {
                    TextField("document-new-drawer-name", text: $newDrawerName)
                }
                
                TextField("document-description", text: $document.documentDescription, axis: .vertical)
            }
            .navigationTitle("add-document")
            .navigationBarItems(
                leading: Button("cancel") {
                    dismiss()
                },
                trailing: Button("done") {
                    addDrawer()
                    dismiss()
                }
                    .disabled(!canUpdateDocument)
            )
            .onAppear {
                selectedDrawer = drawers.first { $0.name == document.drawer }
            }
        }
    }
    
    private var canUpdateDocument: Bool {
        !document.name.isEmpty && (selectedDrawer != nil || !newDrawerName.isEmpty)
    }
    
    private func addDrawer() {
        let drawerName = selectedDrawer?.name ?? newDrawerName
        if selectedDrawer == nil, !drawerName.isEmpty {
            let newDrawer = Drawer(name: drawerName)
            document.drawer = newDrawer.name
            context.insert(newDrawer)
        }
    }
}

#Preview {
    UpdateDocumentView(document: Document(name: "Document", drawer: "Drawer", documentDescription: "Description"))
}