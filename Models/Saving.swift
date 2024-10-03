//
//  Saving.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import Foundation
import SwiftData

@Model
final class Saving {
    var name: String
    var goal: Int
    var startDate = Date()
    var isFinished = false
    var finishDate: Date?
    var imageName: String
    @Relationship(deleteRule: .cascade, inverse: \Record.account)
    var records = [Record]()
    
    init(name: String, goal: Int, imageName: String) {
        self.name = name
        self.goal = goal
        self.imageName = imageName
    }
}
