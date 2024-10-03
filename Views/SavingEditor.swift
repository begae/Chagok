//
//  SavingEditor.swift
//  Chagok
//
//  Created by 김세령 on 9/27/24.
//

import SwiftUI
import SwiftData

struct SavingEditor: View {
    var saving: Saving?
    
    private var editorTitle: String {
        saving == nil ? "Start Saving" : "Edit Saving"
    }
    
    @State private var name = ""
    @State private var selectedDate = Date()
    @State private var enteredAmount: Int = 0
    
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
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
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
        }
    }
    
    private func save() {
        if let saving {
            saving.name = name
            saving.goal = enteredAmount
            saving.startDate = selectedDate
        } else {
            let newSaving = Saving(name: name, goal: enteredAmount, imageName: "macbook")
            newSaving.startDate = selectedDate
            modelContext.insert(newSaving)
        }
    }
}

