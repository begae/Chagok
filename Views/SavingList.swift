//
//  SavingList.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import SwiftUI
import SwiftData

struct SavingList: View {
    //@Query(sort: \Saving.startDate, order: .reverse) private var savings: [Saving]
    var savings: [Saving]
    @State private var isStartingPhase = false
    
    var body: some View {
        NavigationSplitView {
            List(savings) { saving in
                NavigationLink {
                    SavingDetail(saving: saving)
                } label: {
                    SavingRow(saving: saving)
                }
                .tag(saving)
            }
            .navigationTitle("My Savings")
        } detail: {
            Text("Select a saving")
        }
    }
}

#Preview {
    SavingList(savings: [Saving(name: "macbook air", goal: 1500000, imageName: "ipadair13"), Saving(name: "ipad air", goal: 1000000, imageName: "ipadair13"), Saving(name: "iPhone", goal: 1200000, imageName: "ipadair13"), Saving(name: "macbook air", goal: 1500000, imageName: "ipadair13"), Saving(name: "ipad air", goal: 1000000, imageName: "ipadair13"), Saving(name: "iPhone", goal: 1200000, imageName: "ipadair13")])
}
