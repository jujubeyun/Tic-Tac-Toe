//
//  OptionView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/27/24.
//

import SwiftUI

struct OptionView: View {
    
    @Binding var isSinglePlayer: Bool
    @Binding var selectedDifficulty: Difficulty
    
    var body: some View {
        Toggle("Single Player", isOn: $isSinglePlayer)
            .tint(.indigo).font(.title3).padding()
        
        Picker("Difficulty", selection: $selectedDifficulty) {
            ForEach(Difficulty.allCases) { difficulty in
                Text(difficulty.rawValue.capitalized)
            }
        }
        .pickerStyle(.segmented)
        .disabled(!isSinglePlayer)
    }
}

#Preview {
    OptionView(isSinglePlayer: .constant(true),
               selectedDifficulty: .constant(.easy))
}
