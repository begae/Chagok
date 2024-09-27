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
    @Attribute(.unique) var name: String
    var goal: Int
    var current: Int = 0
    var startDate = Date()
    var isFinished = false
    var finishDate: Date?
    var imageName: String
    @Relationship(deleteRule: .cascade, inverse: \Record.account)
    var history = [Record]()
    
    init(name: String, goal: Int, imageName: String) {
        self.name = name
        self.goal = goal
        self.imageName = imageName
    }
}