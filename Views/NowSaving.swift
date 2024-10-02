//
//  NowSaving.swift
//  Chagok
//
//  Created by 김세령 on 9/27/24.
//

import SwiftUI
import SwiftData

struct NowSaving: View {
    var saving: Saving?
    @Environment(\.modelContext) private var modelContext
    @State private var isRecordEditorPresented = false
    @State private var isSavingEditorPresented = false
    
    var body: some View {
        
        if saving == nil {
            VStack {
                HStack {
                    Text("Chagok")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                }
                .padding()
                ContentUnavailableView {
                    Label("Not quite saving at the moment", systemImage: "dollarsign")
                } description: {
                    StartSavingButton(isActive: $isSavingEditorPresented)
                        .sheet(isPresented: $isSavingEditorPresented) {
                            SavingEditor(saving: nil)
                        }
                }
            }
        } else {
            let current = saving!.records.map { $0.amount }.reduce(0, +)
            
            VStack {
                HStack {
                    Text("Chagok")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                }
                .padding()
                Image(saving!.imageName)
                    .resizable()
                    .scaledToFit()
                    .overlay (
                        LinearGradient(colors: [.white.opacity(1), .white.opacity(0)], startPoint: .top, endPoint: .bottom)
                    )
                    .overlay {
                        VStack {
                            HStack {
                                Spacer()
                                Text(saving!.name)
                                    .font(.title).bold()
                            }
                            HStack {
                                Spacer()
                                Text("\(current) going on \(saving!.goal)")
                                    .font(.title2)
                            }
                            Spacer()
                            AddRecordButton(isActive: $isRecordEditorPresented)
                                .sheet(isPresented: $isRecordEditorPresented) {
                                    RecordEditor(saving: saving!)
                                }
                        }
                    }
            }
        }
    }
}

    
#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        NowSaving(saving: Saving.macbook)
    }
}
