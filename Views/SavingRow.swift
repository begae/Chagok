//
//  SavingRow.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import SwiftUI

struct SavingRow: View {
    var saving: Saving
    
    var body: some View {
        ZStack {
            Image(saving.imageName)
                .resizable()
                .scaledToFit()
                .overlay (
                    Gradient(colors: [.black.opacity(0.3)])
                )
                .clipShape(Circle())
                //.clipShape(RoundedRectangle(cornerRadius: 10))
            VStack {
                Text("\(saving.current)")
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
    SavingRow(saving: Saving(name: "iPad air 13", goal: 1200000, imageName: "ipadair13"))
}
