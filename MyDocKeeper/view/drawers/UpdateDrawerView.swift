//
//  UpdateDrawerView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 5/2/24.
//

import SwiftUI
import SwiftData

struct UpdateDrawerView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var drawer: Drawer
    @State private var oldDrawerName: String = ""
    @Query private var documents: [Document]
    
    private var canUpdateDrawer: Bool {
        !drawer.name.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Drawer name", text: $drawer.name)
            }
            .navigationTitle("add-document")
            .onAppear {
                self.oldDrawerName = drawer.name
            }
            .navigationBarItems(
                leading: Button("cancel") {
                    drawer.name = oldDrawerName
                    dismiss()
                },
                trailing: Button("done") {
                    dismiss()
                    updateDrawer()
                }
                    .disabled(!canUpdateDrawer)
            )
        }
    }
    
    private func updateDrawer() {
        for document in documents {
            if (document.drawer == oldDrawerName) {
                document.drawer = drawer.name
            }
        }
    }
    
}

#Preview {
    UpdateDrawerView(drawer: Drawer(name: "Drawer"))
}
