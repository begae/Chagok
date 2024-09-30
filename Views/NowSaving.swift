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
    @State private var isEditorPresented = false

    var body: some View {
        if saving == nil {
            
            //StartSavingView()
            ContentUnavailableView("Start saving", systemImage: "dollarsign")
        } else {
            
            let current = saving!.records.map { $0.amount }.reduce(0, +)
            
            VStack {
                Text("Chagok")
                    .bold()
                    .font(.largeTitle)
                    .padding(.init(top: 50, leading: 0, bottom: 20, trailing: 0))
                
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
                        }
                        .padding()
                    }
                
                AddRecordButton(isActive: $isEditorPresented)
            }
        }
    }
}

private struct AddRecordButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Save some more", systemImage: "plus")
                .help("Add a saving record")
        }
        .foregroundStyle(.black)
        .font(.title3).bold()
        .padding(.init(.init(top: 10, leading: 0, bottom: 30, trailing: 0)))
    }
}
    
#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        NowSaving(saving: Saving.macbook)
    }
}
