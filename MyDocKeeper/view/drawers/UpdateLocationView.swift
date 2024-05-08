//
//  UpdateLocationView.swift
//  MyDocKeeper
//
//  Created by Danijal Azerovic on 5/2/24.
//

import SwiftUI
import SwiftData

struct UpdateLocationView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var location: Location
    @State private var oldLocationName: String = ""
    @Query private var documents: [Document]
    
    private var canUpdateLocation: Bool {
        !location.name.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("location-name", text: $location.name)
            }
            .navigationTitle("add-document")
            .onAppear {
                self.oldLocationName = location.name
            }
            .navigationBarItems(
                leading: Button("cancel") {
                    location.name = oldLocationName
                    dismiss()
                },
                trailing: Button("done") {
                    dismiss()
                    updateLocation()
                }
                    .disabled(!canUpdateLocation)
            )
        }
    }
    
    private func updateLocation() {
        for document in documents {
            if (document.location == oldLocationName) {
                document.location = location.name
            }
        }
    }
    
}

#Preview {
    UpdateLocationView(location: Location(name: "Location"))
}
