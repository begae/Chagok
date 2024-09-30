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
    @State private var isStartingPhase = false
    var savings: [Saving]?
    
    var body: some View {
        if savings != nil {
            NavigationSplitView {
                List(savings!) { saving in
                    NavigationLink {
                        SavingDetail(saving: saving)
                    } label: {
                        SavingRow(saving: saving)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .navigationTitle("My Savings")
            } detail: {
                Text("Select a saving")
            }
        } else {
            //StartSavingView()
        }
    }
}
