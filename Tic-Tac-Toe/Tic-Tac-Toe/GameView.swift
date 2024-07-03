//
//  GameView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/27/24.
//

import SwiftUI

struct GameView: View {
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    @State var moves: [String?] = Array(repeating: nil, count: 9)
    @Environment(GameSetting.self) private var gameSetting
    
    var body: some View {
        VStack {
            
            HStack(spacing: 30) {
                ScoreView(symbol: gameSetting.player1Symbol,
                          score: 0)
                ScoreView(symbol: gameSetting.player2Symbol,
                          score: 0)
            }
            
            LazyVGrid(columns: columns) {
                ForEach(0..<9) { i in
                    ZStack {
                        GameSquareView(imageName: moves[i] ?? "")
                    }
                    .onTapGesture {
                        let isEven = i % 2 == 0
                        moves[i] = isEven ? gameSetting.player1Symbol : gameSetting.player2Symbol
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    GameView()
        .environment(GameSetting())
}
