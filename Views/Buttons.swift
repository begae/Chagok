//
//  Buttons.swift
//  Chagok
//
//  Created by 김세령 on 10/2/24.
//

import SwiftUI

struct StartSavingButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Start saving", systemImage: "plus")
                .help("Edit a saving tracker")
        }
    }
}

struct AddRecordButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Save some more", systemImage: "plus")
        }
        .foregroundStyle(.white)
        .font(.title3).bold()
        .padding()
    }
}
