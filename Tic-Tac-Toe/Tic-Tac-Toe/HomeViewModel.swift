//
//  HomeViewModel.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/29/24.
//

import SwiftUI

enum Player: String, Identifiable {
    var id: String { rawValue }
    case player1, player2
}

@Observable final class HomeViewModel {
    var selectedPlayer: Player?
    var isPlaying = false
}
