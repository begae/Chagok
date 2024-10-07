//
//  SavingEditor.swift
//  Chagok
//
//  Created by 김세령 on 9/27/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct SavingEditor: View {
    var saving: Saving?
    
    private var editorTitle: String {
        saving == nil ? "Start Saving" : "Edit Saving"
    }
    
    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var enteredAmount: Int = 0
    @State private var selectedPhotos = [PhotosPickerItem]()
    @State private var selectedPhotosData: Data?
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        let image = saving != nil && saving!.cover != nil ?
                    Image(uiImage: UIImage(data: saving!.cover!)!) :
                    Image("piggy-bank")
        
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
                image
                    .resizable()
                    .scaledToFit()
                    .listRowInsets(EdgeInsets())
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
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
            .onAppear {
                if let saving {
                    name = saving.name
                    enteredAmount = saving.goal
                    selectedDate = saving.startDate
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
        if let saving {
            saving.name = name
            saving.goal = enteredAmount
            saving.startDate = selectedDate
            if let selectedPhotosData {
                saving.cover = selectedPhotosData
            }
        } else {
            let newSaving = Saving(name: name, goal: enteredAmount)
            newSaving.startDate = selectedDate
            if let selectedPhotosData {
                newSaving.cover = selectedPhotosData
            }
            modelContext.insert(newSaving)
        }
    }
}
