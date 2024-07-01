//
//  OptionView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/27/24.
//

import SwiftUI

struct OptionView: View {
    
    @Environment(GameSetting.self) private var gameSetting
    
    var body: some View {
        @Bindable var setting = gameSetting
        
        Toggle("Single Player", isOn: $setting.isSinglePlayer)
            .tint(.indigo).font(.title3).padding()
        
        Picker("Difficulty", selection: $setting.selectedDifficulty) {
            ForEach(Difficulty.allCases) { difficulty in
                Text(difficulty.rawValue.capitalized)
            }
        }
        .pickerStyle(.segmented)
        .disabled(!setting.isSinglePlayer)
    }
}

#Preview {
    OptionView()
        .environment(GameSetting())
}
