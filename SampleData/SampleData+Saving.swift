//
//  SampleData+Saving.swift
//  Chagok
//
//  Created by 김세령 on 9/30/24.
//

import Foundation
import SwiftData

extension Saving {
    static let macbook = Saving(name: "MacBook Pro M1 16\"", goal: 1500000, imageName: "macbook")
    static let ipad = Saving(name: "iPad Air M2 13\"", goal: 1200000, imageName: "ipadair13")
    static let iphone = Saving(name: "iPhone 16 Plus", goal: 1400000, imageName: "iphone")
    static let travel = Saving(name: "Trip to Belgium", goal: 3000000, imageName: "belgium")
    
    static func insertSampleData(modelContext: ModelContext) {
        
        modelContext.insert(macbook)
        modelContext.insert(ipad)
        modelContext.insert(iphone)
        modelContext.insert(travel)
        
        modelContext.insert(Record.mac1)
        modelContext.insert(Record.mac2)
        modelContext.insert(Record.mac3)
        modelContext.insert(Record.mac4)
        modelContext.insert(Record.pad1)
        modelContext.insert(Record.pad2)
        modelContext.insert(Record.pho1)
        modelContext.insert(Record.tra1)
        
        Record.mac1.account = macbook
        Record.mac2.account = macbook
        Record.mac3.account = macbook
        Record.mac4.account = macbook
        Record.pad1.account = ipad
        Record.pad2.account = ipad
        Record.pho1.account = iphone
        Record.tra1.account = travel
    }
    
    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Saving.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
