//
//  GoalImage.swift
//  Chagok
//
//  Created by 김세령 on 9/26/24.
//

import SwiftUI

struct GoalImage: View {
    var status: Double
    
    var body: some View {
        Image("ipadair13")
            .resizable()
            .scaledToFit()
            .overlay (
                Gradient(colors: [.white.opacity(status)])
            )
            
    }
}

#Preview {
    GoalImage(status: 0.5)
}
