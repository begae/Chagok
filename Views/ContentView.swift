//
//  ContentView.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .nowSaving
    var savings: [Saving] = [Saving(name: "macbook air", goal: 1500000, imageName: "ipadair13"), Saving(name: "ipad air", goal: 1000000, imageName: "ipadair13"), Saving(name: "iPhone", goal: 1200000, imageName: "ipadair13")]
    
    enum Tab {
        case nowSaving
        case list
        case settings
    }
    
    var body: some View {
        TabView(selection: $selection) {
            NowSaving(saving: savings[0])
                .tabItem {
                    Label("Now Saving", systemImage: "square.and.arrow.down")
                }
                .tag(Tab.nowSaving)
            
            SavingList(savings: savings)
                .tabItem {
                    Label("My List", systemImage: "person")
                }
                .tag(Tab.list)
            
            Settings()
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }
                .tag(Tab.list)
        }
    }
}

#Preview {
    ContentView()
}
