//
//  ContentView.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selection: Tab = .now
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Saving.startDate, order: .reverse) private var savings: [Saving]
    
    enum Tab {
        case now
        case list
        case more
    }
    
    var body: some View {
        
        let saving: Saving? = savings.first
        
        TabView(selection: $selection) {
            NowSaving(saving: saving)
                .tabItem {
                    Label("Now Saving", systemImage: "square.and.arrow.down")
                }
                .tag(Tab.now)
            
            SavingList(savings: savings)
                .tabItem {
                    Label("My List", systemImage: "person")
                }
                .tag(Tab.list)
            
            Settings()
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }
                .tag(Tab.more)
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ContentView()
    }
}
