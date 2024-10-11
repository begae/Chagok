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
            Label("Start saving", systemImage: "folder.badge.plus")
                .help("Start tracking your saving")
        }
    }
}

struct AddRecordButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add record", systemImage: "document.badge.plus")
                .help("Save more to have it clearer")
        }
    }
}

struct ShowDetailButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("See details", systemImage: "text.page.badge.magnifyingglass")
                .help("Show details of the saving")
        }
    }
}
