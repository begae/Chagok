//
//  FeatureCard.swift
//  Chagok
//
//  Created by 김세령 on 10/8/24.
//

import SwiftUI

struct FeatureCard: View {
    var saving: Saving
    
    @State private var isEditorPresented = false

    var body: some View {
        let current = saving.records.map { $0.amount }.reduce(0, +)
        let status = 0.6 - Double(current) / Double(saving.goal) * 0.6
        let image = saving.cover != nil ?
                    Image(uiImage: UIImage(data: saving.cover!)!) :
                    Image("piggy-bank")

        image
            .resizable()
            .scaledToFit()
            .overlay {
                LinearGradient(colors: [.black.opacity(0.6), .black.opacity(status)], startPoint: .top, endPoint: .center)
            }
            .overlay {
                VStack {
                    HStack {
                        Spacer()
                        Text(saving.name)
                            .font(.title).bold()
                            .foregroundStyle(.white)
                    }
                    HStack {
                        Spacer()
                        Text("\(current) going on \(saving.goal)")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                    Spacer()
                    HStack {
                        AddRecordButton(isActive: $isEditorPresented)
                            .foregroundStyle(.white)
                            .sheet(isPresented: $isEditorPresented) {
                                RecordEditor(saving: saving)
                            }
                        Spacer()
                    }
                }
                .padding()
            }
    }
}
