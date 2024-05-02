//
//  DocumentView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 4/28/24.
//

import SwiftUI
import SwiftData

struct DocumentView: View {
    var document: Document
    @State private var showEdit = false
    
    var body: some View {
        List {
            listItemHorizontal(title: "document-name", value: document.name)
            
            NavigationLink(destination: DrawerView(
                drawer: Drawer(name: document.drawer),
                goToDocumentsClicked: {}
                )
            ) {
                listItemHorizontal(title: "document-located-in", value: document.drawer)
            }
            
            if !document.documentDescription.isEmpty {
                listItemVertical(title: "document-description", value: document.documentDescription)
            }
        }
        .navigationTitle("document-info-title")
        .navigationBarItems(trailing: Button(action: {
            showEdit = true
        }) {
            Text("edit")
        })
        .sheet(isPresented: $showEdit) {
            UpdateDocumentView(document: document)
        }
    }
    
    @ViewBuilder func listItemHorizontal(title: String, value: String) -> some View {
        HStack {
            Text(LocalizedStringKey(title))
            Spacer()
            Text(value)
                .foregroundStyle(.gray)
        }
    }
    
    @ViewBuilder func listItemVertical(title: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(LocalizedStringKey(title))
            Text(value)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    DocumentView(document: Document(name: "Document", drawer: "Drawer", documentDescription: "Description"))
}
