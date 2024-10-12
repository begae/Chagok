//
//  StartSaving.swift
//  Chagok
//
//  Created by 김세령 on 10/12/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct StartSaving: View {
    var savings: [Saving]
        
    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var enteredAmount: Int = 0
    @State private var selectedPhotos = [PhotosPickerItem]()
    @State private var selectedPhotosData: Data?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("Saving Name")
                    Spacer()
                    TextField("Saving Name", text: $name)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                DatePicker(
                    "Started on",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                HStack {
                    Text("Goal Amount")
                    Spacer()
                    TextField("Goal Amount", value: $enteredAmount, format: .number.rounded(rule: .awayFromZero))
                        .keyboardType(.numberPad)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                PhotosPicker(selection: $selectedPhotos, maxSelectionCount: 1, matching: .images, photoLibrary: .shared()) {
                    Label("Select a photo", systemImage: "photo")
                }
                if selectedPhotosData != nil {
                    Image(uiImage: UIImage(data: selectedPhotosData!)!)
                        .resizable()
                        .scaledToFit()
                        .listRowInsets(EdgeInsets())
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Start New Saving")
                        .bold()
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    .disabled($enteredAmount.wrappedValue == 0)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .task(id: selectedPhotos) {
                guard !selectedPhotos.isEmpty else { return }
                
                if let data = try? await selectedPhotos[0].loadTransferable(type: Data.self) {
                    selectedPhotosData = data
                }
            }
        }
    }
    
    private func save() {
        let newSaving = Saving(name: name, goal: enteredAmount)
        newSaving.startDate = selectedDate
        if let selectedPhotosData {
            newSaving.cover = selectedPhotosData
        }
        modelContext.insert(newSaving)
    }
}
