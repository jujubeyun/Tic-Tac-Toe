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
    @Binding var isPlaying: Bool
    @State var moves: [Move?] = Array(repeating: nil, count: 9)
    @State var alert: AlertType
    @State var isShowingAlert = false
    @State var player1Score = 0
    @State var player2Score = 0
    @State var isGameBoardDisabled = false
    @State var isPlayer1Turn = true
    
    let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    
    var body: some View {
        VStack {
            HStack(spacing: 30) {
                ScoreView(isPlayerTurn: isPlayer1Turn,
                          symbol: gameSetting.player1Symbol,
                          score: player1Score)
                ScoreView(isPlayerTurn: !isPlayer1Turn,
                          symbol: gameSetting.player2Symbol,
                          score: player2Score)
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(0..<9) { i in
                    ZStack {
                        GameSquareView(move: moves[i])
                            .onTapGesture {
                                processPlayerMove(for: i)
                            }
                    }
                }
            }
            .disabled(isGameBoardDisabled)
            .padding()
            
            Button {
                showAlert(alert: .reset)
            } label: {
                Text("Reset").frame(width: 280)
            }.modifier(GameButtonStyle())
            
            Button {
                showAlert(alert: .exit)
            } label: {
                Text("Exit").frame(width: 280)
            }.modifier(GameButtonStyle())
        }
        .alert(alert.title, isPresented: $isShowingAlert, presenting: alert) { alert in
            switch alert {
            case .reset:
                Button("OK") { resetGame() }
                Button("Cancel", role: .cancel) {}
            case .exit:
                Button("OK") { isPlaying = false }
                Button("Cancel", role: .cancel) {}
            case .win, .draw:
                Button("OK") { resetMoves() }
            }
        } message: { alert in
            Text(alert.message)
        }
    }
    
    func processPlayerMove(for position: Int) {
        let player: Player = isPlayer1Turn ? .player1 : .player2
        if isSquareOccupied(forIndex: position) { return }
        moves[position] = Move(player: player, boardIndex: position)
        
        if checkGameOver(player: player) { return }
        
        isPlayer1Turn.toggle()
        
        if gameSetting.isSinglePlayer {
            processComputerMove()
        }
    }
    
    func processComputerMove() {
        isGameBoardDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isGameBoardDisabled = false
            let computerPosition = determineComputerMovePosition()
            moves[computerPosition] = Move(player: .player2, boardIndex: computerPosition)
            
            if checkGameOver(player: .player2) { return }
            
            isPlayer1Turn = true
        }
    }
    
    func checkGameOver(player: Player) -> Bool {
        if checkWinCondition(for: player) {
            showAlert(alert: .win(player: player))
            if player == .player1 {
                player1Score += 1
            } else {
                player2Score += 1
            }
            return true
        }
        
        if checkForDraw() {
            showAlert(alert: .draw)
            return true
        }
        
        return false
    }
    
    func showAlert(alert: AlertType) {
        self.alert = alert
        isShowingAlert = true
    }
    
    func determineComputerMovePosition() -> Int {
        // If computer can win, then win
        if gameSetting.selectedDifficulty.level >= 2 {
            if let position = getFinalPiece(for: .player2) {
                return position
            }
        }
        
        if gameSetting.selectedDifficulty.level == 3 {
            // If human can win, then block
            if let position = getFinalPiece(for: .player1) {
                return position
            }
            
            // If computer can't block, then take middle square
            let centerSquare = 4
            if !isSquareOccupied(forIndex: centerSquare) {
                return centerSquare
            }
        }
                
        // If AI can't take middle square, take random available square
        var movePosition = Int.random(in: 0..<9)
        while isSquareOccupied(forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func getFinalPiece(for player: Player) -> Int? {
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(playerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(forIndex: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        
        return nil
    }
    
    func isSquareOccupied(forIndex index: Int) -> Bool {
        return moves.contains { $0?.boardIndex == index }
    }
    
    func checkWinCondition(for player: Player) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        return false
    }
    
    func checkForDraw() -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        resetMoves()
        player1Score = 0
        player2Score = 0
    }
    
    func resetMoves() {
        moves = Array(repeating: nil, count: 9)
        isPlayer1Turn = true
    }
}

#Preview {
    GameView(isPlaying: .constant(true), alert: .draw)
        .environment(GameSetting())
}
