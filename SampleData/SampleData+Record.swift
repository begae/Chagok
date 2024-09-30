//
//  SampleData+Record.swift
//  Chagok
//
//  Created by 김세령 on 9/30/24.
//

import Foundation

extension Record {
    static let mac1 = Record(amount: 200000, date: Date(timeIntervalSinceNow: -20000000))
    static let mac2 = Record(amount: -10000, date: Date(timeIntervalSinceNow: -19980000))
    static let mac3 = Record(amount: 100000, date: Date(timeIntervalSinceNow: -18880000))
    static let mac4 = Record(amount: 400000, date: Date(timeIntervalSinceNow: -17777000))
    static let pad1 = Record(amount: 300000, date: Date(timeIntervalSinceNow: -200000))
    static let pad2 = Record(amount: -10000, date: Date(timeIntervalSinceNow: -150000))
    static let pho1 = Record(amount: 500000, date: Date(timeIntervalSinceNow: -500000))
    static let tra1 = Record(amount: 1000000, date: Date(timeIntervalSinceNow: -1000))
}
