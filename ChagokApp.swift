//
//  ChagokApp.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import SwiftUI

@main
struct ChagokApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Saving.self)
        }
    }
}
