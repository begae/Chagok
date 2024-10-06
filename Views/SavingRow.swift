//
//  SavingRow.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import Foundation
import SwiftUI

struct SavingRow: View {
    var saving: Saving
    var current: Int = 2000
    
    var body: some View {
        let image = saving.cover != nil ?
                    Image(uiImage: UIImage(data: saving.cover!)!) :
                    Image("piggy-bank")
        
        ZStack {
            image
                .resizable()
                .frame(height: 300)
                .overlay (
                    Gradient(colors: [.black.opacity(0.3)])
                )
                
            VStack {
                Text("\(saving.records.map { $0.amount }.reduce(0, +))")
                    .bold()
                    .font(.title)
                Text("From " + saving.startDate.formatted(date: .abbreviated, time: .omitted))
                if saving.isFinished {
                    Text("To " + saving.finishDate!.formatted(date: .abbreviated, time: .omitted))
                }
            }
            .foregroundStyle(.white)
        }
    }
    
}

#Preview {
    SavingRow(saving: Saving(name: "iPad air 13", goal: 1200000))
}
