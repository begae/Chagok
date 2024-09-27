//
//  NowSaving.swift
//  Chagok
//
//  Created by 김세령 on 9/27/24.
//

import SwiftUI

struct NowSaving: View {
    var saving: Saving
    
    
    
    var body: some View {
        Text("\(saving.current)")
    }
}

#Preview {
    NowSaving(saving: Saving(name: "macbook air", goal: 1500000, imageName: "ipadair13"))
}
