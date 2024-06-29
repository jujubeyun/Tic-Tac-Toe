//
//  HomeViewModel.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/29/24.
//

import SwiftUI

enum Difficulty: String, Identifiable, CaseIterable {
    var id: Self { self }
    case easy, medium, hard
}

enum Player: String, Identifiable {
    var id: String { rawValue }
    case player1, player2
}

@Observable final class HomeViewModel {
    var isSinglePlayer = true
    var selectedDifficulty: Difficulty = .easy
    var selectedPlayer: Player?
    var player1Symbol = "xmark"
    var player2Symbol = "circle"
}
