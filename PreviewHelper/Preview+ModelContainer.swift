//
//  Preview+ModelContainer.swift
//  Chagok
//
//  Created by 김세령 on 9/30/24.
//

import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([Saving.self, Record.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        Task { @MainActor in
            Saving.insertSampleData(modelContext: container.mainContext)
        }
        return container
    }
}
