//
//  Tic_Tac_ToeApp.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/25/24.
//

import SwiftUI

@main
struct Tic_Tac_ToeApp: App {
    
    @State private var gameSetting = GameSetting()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(gameSetting)
        }
    }
}
