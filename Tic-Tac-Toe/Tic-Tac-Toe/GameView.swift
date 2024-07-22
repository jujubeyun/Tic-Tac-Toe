//
//  GameView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/27/24.
//

import SwiftUI

struct Move {
    let player: Player
    let boardIndex: Int
}

struct GameView: View {
    
    @Environment(GameSetting.self) private var gameSetting
    @State var moves: [Move?] = Array(repeating: nil, count: 9)
    @State var alertItem: AlertItem?
    @State var player1Score = 0
    @State var player2Score = 0
    
    let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var body: some View {
        VStack {
            HStack(spacing: 30) {
                ScoreView(symbol: gameSetting.player1Symbol,
                          score: player1Score)
                ScoreView(symbol: gameSetting.player2Symbol,
                          score: player2Score)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(0..<9) { i in
                    let player: Player = moves.compactMap { $0 }.count % 2 == 0 ? .player1 : .player2
                    ZStack {
                        GameSquareView(move: moves[i])
                            .onTapGesture {
                                guard moves[i] == nil else { return }
                                moves[i] = Move(player: player, boardIndex: i)
                                checkForDraw()
                                checkWinCondition(for: player)
                            }
                    }
                }
            }
            .padding()
            .alert(item: $alertItem) { alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: .default(alertItem.buttonTitle, action: { resetGame() }))
            }
        }
    }
    
    func checkWinCondition(for player: Player) {
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { 
            switch player {
            case .player1:
                alertItem = AlertContext.player1Win
                player1Score += 1
            case .player2:
                alertItem = AlertContext.player2Win
                player2Score += 1
            }
        }
    }
    
    func checkForDraw() {
        if moves.compactMap({$0}).count == 9 {
            alertItem = AlertContext.draw
        }
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}

#Preview {
    GameView()
        .environment(GameSetting())
}
