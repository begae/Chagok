//
//  NowSaving.swift
//  Chagok
//
//  Created by 김세령 on 9/27/24.
//

import SwiftUI
import SwiftData

struct NowSaving: View {
    var saving: Saving?
    @Environment(\.modelContext) private var modelContext
    @State private var isRecordEditorPresented = false
    @State private var isSavingEditorPresented = false
    
    var body: some View {
        
        if saving == nil {
            VStack {
                HStack {
                    Text("Chagok")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                }
                .padding()
                ContentUnavailableView {
                    Label("Not quite saving at the moment", systemImage: "dollarsign")
                } description: {
                    StartSavingButton(isActive: $isSavingEditorPresented)
                        .sheet(isPresented: $isSavingEditorPresented) {
                            SavingEditor(saving: nil)
                        }
                }
            }
        } else {
            let current = saving!.records.map { $0.amount }.reduce(0, +)
            let status = 0.8 - Double(current / saving!.goal)
            let image = saving!.cover != nil ?
                        Image(uiImage: UIImage(data: saving!.cover!)!) :
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
                                       startPoint: .top, endPoint: .center)
                    )
                    .overlay {
                        VStack {
                            HStack {
                                Spacer()
                                Text(saving!.name)
                                    .font(.title).bold()
                            }
                            HStack {
                                Spacer()
                                Text("\(current) going on \(saving!.goal)")
                                    .font(.title2)
                            }
                            Spacer()
                        }
                        .padding()
                    }
                HStack {
                    AddRecordButton(isActive: $isRecordEditorPresented)
                        .sheet(isPresented: $isRecordEditorPresented) {
                            RecordEditor(saving: saving!)
                        }
                        .labelStyle(.titleOnly)
                        .foregroundStyle(.black)
                        .font(.title2)
                }
                .padding()
            }
        }
    }
}
