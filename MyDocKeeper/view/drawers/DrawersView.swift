//
//  DrawersView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 5/2/24.
//

import SwiftUI
import SwiftData

struct DrawersView: View {
    @Environment(\.modelContext) private var context
    
    var goToDocumentsClicked: () -> Void
    
    @State private var showDeleteAlert: Bool = false
    @State private var indexSetToDelete: IndexSet = IndexSet()
    
    @State private var searchTerm: String = ""
    @Query private var drawers: [Drawer]
    @Query private var documents: [Document]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(drawers.filter {
                    searchTerm.isEmpty ? true :
                    $0.name.localizedCaseInsensitiveContains(searchTerm)
                }) { drawer in
                    NavigationLink(destination: DrawerView(drawer: drawer)) {
                        Text(drawer.name)
                    }
                }
                .onDelete { indexSet in
                    self.indexSetToDelete = indexSet
                    self.showDeleteAlert = true
                }
            }
            .navigationTitle("drawers-title")
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
            .alert("delete", isPresented: $showDeleteAlert, actions: {
                Button("no") {}
                Button("yes") {
                    deleteDrawer(indexSet: indexSetToDelete)
                }
            }, message: {
                Text("drawer-alert-message")
            })
            .overlay {
                if drawers.isEmpty {
                    ContentUnavailableView(label: {
                        Label("no-drawers", systemImage: "list.bullet.rectangle.portrait")
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
    
    private func deleteDrawer(indexSet: IndexSet) {
        for index in indexSet {
            let documentsToDelete = documents.filter { document in
                document.drawer == drawers[index].name
            }
            for document in documentsToDelete {
                context.delete(document)
            }
            context.delete(drawers[index])
        }
    }
}

#Preview {
    DrawersView(goToDocumentsClicked: {})
}
