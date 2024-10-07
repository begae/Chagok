//
//  NowSaving.swift
//  Chagok
//
//  Created by 김세령 on 9/27/24.
//

import SwiftUI
import SwiftData

struct NowSaving: View {
    @ObservedObject var saving: Saving
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var isEditorPresented = false
    
    var body: some View {
        
        let current = saving.records.map { $0.amount }.reduce(0, +)
        let status = 0.8 - (Double(current / saving.goal) * 0.8)
        let image = saving.cover != nil ?
                    Image(uiImage: UIImage(data: saving.cover!)!) :
                    Image("piggy-bank")
            
        VStack {
            HStack {
                Text("Chagok")
                    .bold()
                    .font(.largeTitle)
                Spacer()
            }
            .padding()
            image
                .resizable()
                .scaledToFit()
                .overlay (
                    LinearGradient(colors: [.white.opacity(1), .white.opacity(status)],
                                   startPoint: .top, endPoint: .bottom)
                )
                .overlay {
                    VStack {
                        HStack {
                            Spacer()
                            Text(saving.name)
                                .font(.title).bold()
                        }
                        HStack {
                            Spacer()
                            Text("\(current) going on \(saving.goal)")
                                .font(.title2)
                        }
                        Spacer()
                        HStack {
                            AddRecordButton(isActive: $isEditorPresented)
                                .sheet(isPresented: $isEditorPresented) {
                                    RecordEditor(saving: saving)
                                }
                            Spacer()
                        }
                    }
                    .shadow(color: .white, radius: 15)
                    .padding()
                }
        }
    }
}
