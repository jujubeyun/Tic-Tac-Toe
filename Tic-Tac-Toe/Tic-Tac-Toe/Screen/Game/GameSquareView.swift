//
//  GameSquareView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 7/2/24.
//

import SwiftUI

struct GameSquareView: View {
    
    @Environment(GameSetting.self) private var gameSetting
    
    let move: Move?
    
    var imageName: String {
        if move == nil {
            return ""
        } else {
            return move?.player == .player1 ? gameSetting.player1Symbol : gameSetting.player2Symbol
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.indigo.gradient)
                .opacity(0.5)
            
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .fontWeight(.medium)
                .frame(width: 60)
        }
    }
}


#Preview {
    GameSquareView(move: nil)
        .environment(GameSetting())
}

