//
//  HomeView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/25/24.
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

struct HomeView: View {
    
    @State var isSinglePlayer = true
    @State var selectedDifficulty: Difficulty = .easy
    @State var selectedPlayer: Player?
    @State var player1Symbol = "xmark"
    @State var player2Symbol = "circle"
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("👾 Tiki Taki 👾")
                .font(.system(size: 50, weight: .bold))
            
            PlayerView(selectedPlayer: $selectedPlayer,
                      player1Symbol: $player1Symbol,
                      player2Symbol: $player2Symbol)
            
            OptionView(isSinglePlayer: $isSinglePlayer,
                       selectedDifficulty: $selectedDifficulty)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Game Start").frame(width: 280)
            }.modifier(TTButtonStyle())
        }
        .sheet(item: $selectedPlayer) { player in
            switch player {
            case .player1:
                SymbolView(selectedPlayer: $selectedPlayer, symbol: $player1Symbol)
                    .presentationDetents([.fraction(0.43)])
            case .player2:
                SymbolView(selectedPlayer: $selectedPlayer, symbol: $player2Symbol)
                    .presentationDetents([.fraction(0.43)])
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
