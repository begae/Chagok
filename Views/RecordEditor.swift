//
//  RecordEditor.swift
//  Chagok
//
//  Created by 김세령 on 10/2/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct RecordEditor: View {
    var saving: Saving
    
    @State private var selectedDate = Date()
    @State private var enteredAmount: Int = 0
    @State private var isWithdrawal = false
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker(
                    "Added on",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                HStack {
                    Text("Amount")
                    Spacer()
                    TextField("Amount", value: $enteredAmount, format: .number.rounded(rule: .awayFromZero))
                        .keyboardType(.numberPad)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                Toggle("Withdrawal", isOn: $isWithdrawal)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add Record")
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
        }
    }
    
    private func save() {
        let amount = isWithdrawal ? -1 * enteredAmount : enteredAmount
        let newRecord = Record(amount: amount, date: selectedDate)
        newRecord.account = saving
        saving.records.append(newRecord)
        modelContext.insert(newRecord)
    }
}
