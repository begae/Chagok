//
//  Saving.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import Foundation
import SwiftData
import PhotosUI

@Model
final class Saving: ObservableObject {
    
    var name: String
    var goal: Int
    var startDate = Date()
    var isFinished = false
    var finishDate: Date?
    
    @Relationship(deleteRule: .cascade, inverse: \Record.account)
    var records = [Record]()
    
    init(name: String, goal: Int) {
        self.name = name
        self.goal = goal
    }

    @Attribute(.externalStorage)
    var cover: Data?
}
