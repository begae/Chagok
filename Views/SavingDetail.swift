//
//  SavingDetail.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import SwiftUI
import SwiftData

struct SavingDetail: View {
    var saving: Saving?
    @State private var isEditing = false
    @State private var isDeleting = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        if let saving {
            SavingDetailContentView(saving: saving)
                .navigationTitle("\(saving.name)")
                .toolbar {
                    Button { isEditing = true } label: {
                        Label("Edit", systemImage: "pencil")
                            .help("Edit the saving")
                    }
                    
                    Button { isDeleting = true } label: {
                        Label("Delete", systemImage: "trash")
                            .help("Delete the saving")
                    }
                }
                .sheet(isPresented: $isEditing) {
                    SavingEditor(saving: saving)
                }
                .alert("Delete \(saving.name)?", isPresented: $isDeleting) {
                    Button("Yes, delete \(saving.name)", role: .destructive) {
                        delete(saving)
                    }
                }
        } else {
            ContentUnavailableView("Select a saving", systemImage: "wonsign")
        }
    }
    
    private func delete(_ saving: Saving) {
        modelContext.delete(saving)
    }
}

private struct SavingDetailContentView: View {
    let saving: Saving

    var body: some View {
        List {
            
            HStack {
                Text("Started on")
                Spacer()
                Text(saving.startDate.formatted(date: .complete, time: .omitted)).bold()
            }
            HStack {
                Text("Current amount")
                Spacer()
                Text("\(saving.records.map { $0.amount }.reduce(0, +))").bold()
            }
            HStack {
                Text("Goal amount")
                Spacer()
                Text("\(saving.goal)").bold()
            }
            
            Image(saving.imageName)
                .resizable()
                .scaledToFit()
                .listRowInsets(EdgeInsets())
            
            ForEach(saving.records) { record in
                HStack {
                    Text(record.date.formatted(date: .abbreviated, time: .omitted))
                    Spacer()
                    Text("\(record.amount)").bold()
                }
            }
        }
    }
}
