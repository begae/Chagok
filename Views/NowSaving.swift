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
    
    var body: some View {
        NavigationSplitView {
            List {
                PageView(pages: savings.map { FeatureCard(saving: $0) })
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Chagok")
        } detail: {
            Text("Select a saving")
        }
    }
}
