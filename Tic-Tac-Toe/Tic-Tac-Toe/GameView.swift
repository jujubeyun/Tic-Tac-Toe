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
        let player: Player = moves.compactMap { $0 }.count % 2 == 0 ? .player1 : .player2
        if isSquareOccupied(forIndex: position) { return }
        moves[position] = Move(player: player, boardIndex: position)
        
        if checkWinCondition(for: player) {
            showAlert(alert: .win(player: player))
            if player == .player1 {
                player1Score += 1
            } else {
                player2Score += 1
            }
            return
        }
        
        if checkForDraw() {
            showAlert(alert: .draw)
            return
        }
        
        isGameBoardDisabled = true
        
        if gameSetting.isSinglePlayer {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                isGameBoardDisabled = false
                let computerPosition = determineComputerMovePosition()
                moves[computerPosition] = Move(player: .player2, boardIndex: computerPosition)
                
                if checkWinCondition(for: .player2) {
                    showAlert(alert: .win(player: .player2))
                    player2Score += 1
                    return
                }
                
                if checkForDraw() {
                    showAlert(alert: .draw)
                    return
                }
            }
        } else {
            isGameBoardDisabled = false
        }
    }
    
    func showAlert(alert: AlertType) {
        self.alert = alert
        isShowingAlert = true
    }
    
    func determineComputerMovePosition() -> Int {
        // If AI can win, then win
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .player2 }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(forIndex: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        
//         If AI can't win, then block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .player1 }
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(forIndex: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }
        
//         If AI can't block, then take middle square
        let centerSquare = 4
        if !isSquareOccupied(forIndex: centerSquare) {
            return centerSquare
        }
        
        
        // If AI can't take middle square, take random available square
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
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
    }
}

#Preview {
    GameView(isPlaying: .constant(true), alert: .draw)
        .environment(GameSetting())
}
