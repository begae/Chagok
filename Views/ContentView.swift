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
    
    @Query(filter: #Predicate<Saving> { saving in
        saving.isFinished == false
    }, sort: \Saving.startDate, order: .reverse) private var ongoing: [Saving]
    
    @Query(sort: \Saving.startDate, order: .reverse) private var savings: [Saving]
    
    enum Tab {
        case now
        case list
    }
    
    var body: some View {
                
        TabView(selection: $selection) {
            if ongoing.isEmpty {
                EmptyNow()
                    .tabItem {
                        Label("Now Saving", systemImage: "square.and.arrow.down")
                    }
                    .tag(Tab.now)
            } else {
                NowSaving(savings: ongoing)
                    .tabItem {
                        Label("Now Saving", systemImage: "square.and.arrow.down")
                    }
                    .tag(Tab.now)
            }
            SavingList(savings: savings)
                .tabItem {
                    Label("My List", systemImage: "person")
                }
                .tag(Tab.list)
        }
    }
}
