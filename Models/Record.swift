//
//  Record.swift
//  Chagok
//
//  Created by 김세령 on 9/27/24.
//

import Foundation
import SwiftData

@Model
final class Record {
    var account: Saving?
    var amount: Int
    var date: Date
    
    init(amount: Int, date: Date) {
        self.amount = amount
        self.date = date
    }
}
