//
//  PlayerView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/27/24.
//

import SwiftUI

struct PlayerView: View {
    
    @Binding var selectedPlayer: Player?
    @Environment(GameSetting.self) private var gameSetting
    
    var body: some View {
        HStack {
            
            VStack {
                Button {
                    selectedPlayer = .player1
                } label: {
                    PlayerImage(imageName: gameSetting.player1Symbol)
                }
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                )
                
                Text("Player 1")
            }
            
            Text("vs")
                .font(.title)
                .padding()
            
            VStack {
                Button {
                    selectedPlayer = .player2
                } label: {
                    PlayerImage(imageName: gameSetting.player2Symbol)
                }
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                )
                
                Text("Player 2")
            }
        }
    }
}

#Preview {
    PlayerView(selectedPlayer: .constant(.player1))
        .environment(GameSetting())
}

struct PlayerImage: View {
    
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .tint(Color(.label))
            .fontWeight(.medium)
            .padding()
            .frame(width: 120, height: 150)
    }
}
