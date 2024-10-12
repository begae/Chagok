//
//  NowSaving.swift
//  Chagok
//
//  Created by 김세령 on 9/27/24.
//

import SwiftUI
import SwiftData

struct NowSaving: View {
    var savings: [Saving]
    
    @Environment(\.modelContext) private var modelContext
    @State private var isEditorPresented = false
    
    var body: some View {
        if savings.isEmpty {
            EmptyNow(savings: savings)
        } else {
            NavigationSplitView {
                List {
                    PageView(pages: savings.map { FeatureCard(saving: $0) })
                        .listRowInsets(EdgeInsets())
                }
                .sheet(isPresented: $isEditorPresented) {
                    StartSaving(savings: savings)
                }
                .listStyle(.inset)
                .navigationTitle("Chagok")
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
}

struct EmptyNow: View {
    var savings: [Saving]
    @Environment(\.modelContext) private var modelContext
    @State private var isEditorPresented = false
    
    var body: some View {
        NavigationSplitView {
            ContentUnavailableView {
                Label("Not quite saving at the moment", systemImage: "dollarsign")
            } description: {
                StartSavingButton(isActive: $isEditorPresented)
                    .sheet(isPresented: $isEditorPresented) {
                        StartSaving(savings: savings)
                    }
            }
            .navigationTitle("Chagok")
        } detail: {
            Text("Select a saving")
        }
    }
}
