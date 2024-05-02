//
//  ContentView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/28/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    
    @State private var searchTerm: String = ""
    @State private var showAddDocument = false
    @State private var showSettings = false
    @Query private var documents: [Document]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(documents.filter {
                    searchTerm.isEmpty ? true : 
                    $0.name.localizedCaseInsensitiveContains(searchTerm) ||
                    $0.drawer.localizedCaseInsensitiveContains(searchTerm)
                }) { document in
                    NavigationLink(destination: DocumentView(document: document)) {
                        Text(document.name)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(documents[index])
                    }
                }
            }
            .navigationTitle("documents-title")
            .navigationBarItems(
                leading: Button(action: {
                    showSettings.toggle()
                }, label: {
                    Image(systemName: "gear")
                }),
                trailing: Button(action: {
                    showAddDocument.toggle()
                }) {
                    Image(systemName: "plus")
                })
            .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
            .sheet(isPresented: $showAddDocument) {
                AddDocumentView()
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
            .overlay {
                if documents.isEmpty {
                    ContentUnavailableView(label: {
                        Label("no-documents", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("no-documents-text")
                    }, actions: {
                        Button("add-document") {
                            showAddDocument = true
                        }
                    })
                    .offset(y: -60)
                }
            }
        }
    }
}

#Preview {
    MainView()
}
