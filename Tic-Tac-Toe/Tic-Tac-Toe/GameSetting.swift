//
//  GameSetting.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 7/1/24.
//

import Foundation

enum Difficulty: String, Identifiable, CaseIterable {
    var id: Self { self }
    case easy, medium, hard
}

@Observable final class GameSetting {
    var player1Symbol = "xmark"
    var player2Symbol = "circle"
    var isSinglePlayer = true
    var selectedDifficulty: Difficulty = .easy
}
