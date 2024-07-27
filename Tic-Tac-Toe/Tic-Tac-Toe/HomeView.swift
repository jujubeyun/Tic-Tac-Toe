//
//  HomeView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/25/24.
//

import SwiftUI

enum Player: String, Identifiable {
    var id: String { rawValue }
    case player1, player2
}

struct HomeView: View {
    
    @State var selectedPlayer: Player?
    @State var isPlaying = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("👾 Tiki Taki 👾")
                .font(.system(size: 50, weight: .bold))
            
            PlayerView(selectedPlayer: $selectedPlayer)
            
            OptionView()
            
            Spacer()
            
            Button {
                isPlaying = true
            } label: {
                Text("Game Start").frame(width: 280)
            }.modifier(GameButtonStyle())
        }
        .sheet(item: $selectedPlayer) { player in
            switch player {
            case .player1:
                SymbolView(selectedPlayer: $selectedPlayer)
                    .presentationDetents([.fraction(0.43)])
            case .player2:
                SymbolView(selectedPlayer: $selectedPlayer)
                    .presentationDetents([.fraction(0.43)])
            }
        }
        .fullScreenCover(isPresented: $isPlaying) {
            GameView(isPlaying: $isPlaying, alert: .draw)
        }
        .padding()
    }
}

#Preview {
    HomeView()
        .environment(GameSetting())
}
