//
//  SavingList.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import SwiftUI
import SwiftData

struct SavingList: View {
    @Environment(\.modelContext) private var modelContext
    @State private var isEditorPresented = false
    var savings: [Saving]
    
    var body: some View {
        
        NavigationSplitView {
            List(savings) { saving in
                NavigationLink {
                    SavingDetail(saving: saving)
                } label: {
                    SavingRow(saving: saving)
                }
            }
            .sheet(isPresented: $isEditorPresented) {
                SavingEditor(saving: nil)
            }
            .navigationTitle("My Savings")
            .overlay {
                if savings.isEmpty {
                    ContentUnavailableView {
                        Label("No savings in your list", systemImage: "wonsign")
                    } description: {
                        StartSavingButton(isActive: $isEditorPresented)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    StartSavingButton(isActive: $isEditorPresented)
                }
            }
        } detail: {
            Text("Select a saving")
        }
    }
}
