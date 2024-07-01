//
//  PlayerView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/27/24.
//

import SwiftUI

struct PlayerView: View {
    
    @Binding var selectedPlayer: Player?
    @Binding var player1Symbol: String
    @Binding var player2Symbol: String
    
    var body: some View {
        HStack {
            Button {
                selectedPlayer = .player1
            } label: {
                PlayerImage(imageName: player1Symbol)
            }
            .overlay (
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
            )
            
            Text("vs")
                .font(.title)
                .padding()
            
            Button {
                selectedPlayer = .player2
            } label: {
                PlayerImage(imageName: player2Symbol)
            }
            .overlay (
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
            )
        }
    }
}

#Preview {
    PlayerView(selectedPlayer: .constant(.player1),
               player1Symbol: .constant("xmark"),
               player2Symbol: .constant("circle"))
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
