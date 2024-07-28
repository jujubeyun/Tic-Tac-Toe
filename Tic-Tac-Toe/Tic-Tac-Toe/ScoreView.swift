//
//  ScoreView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 7/2/24.
//

import SwiftUI

struct ScoreView: View {
    
    var isPlayerTurn: Bool
    var symbol: String
    var score: Int
    
    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: symbol)
                .font(.title)
                .bold()
            
            Text(score == 0 ? "-" : "\(score)")
                .font(.title2)
        }
        .frame(width: 150, height: 50)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(isPlayerTurn ? .systemIndigo : .label), lineWidth: 3)
                .animation(.easeInOut, value: isPlayerTurn)
        }
    }
}

#Preview {
    ScoreView(isPlayerTurn: true, symbol: "xmark", score: 0)
}
