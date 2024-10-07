//
//  EmptyNow.swift
//  Chagok
//
//  Created by 김세령 on 10/7/24.
//

import SwiftUI
import SwiftData

struct EmptyNow: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var isEditorPresented = false
    
    var body: some View {
        
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
                StartSavingButton(isActive: $isEditorPresented)
                    .sheet(isPresented: $isEditorPresented) {
                        SavingEditor(saving: nil)
                    }
            }
        }
    }
}
