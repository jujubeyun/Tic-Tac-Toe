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
                Image(systemName: player1Symbol)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .tint(Color(.label))
                    .fontWeight(.medium)
                    .padding()
                    .frame(width: 120, height: 150)
            }
            .background(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 3))
            
            Text("vs")
                .font(.title)
                .padding()
            
            Button {
                selectedPlayer = .player2
            } label: {
                Image(systemName: player2Symbol)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .tint(Color(.label))
                    .fontWeight(.medium)
                    .padding()
                    .frame(width: 120, height: 150)
            }
            .background(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 3))
        }
    }
}

#Preview {
    PlayerView(selectedPlayer: .constant(.player1),
               player1Symbol: .constant("xmark"),
               player2Symbol: .constant("circle"))
}
