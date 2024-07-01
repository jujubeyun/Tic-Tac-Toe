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
    
    var body: some View {
        VStack {
            
            HStack(spacing: 30) {
                ScoreView(symbol: "xmark", score: 0)
                ScoreView(symbol: "circle", score: 0)
            }
            
            LazyVGrid(columns: columns) {
                ForEach(0..<9) { i in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.indigo.gradient)
                            .opacity(0.5)
                        
                        Image(systemName: moves[i] ?? "")
                            .resizable()
                            .fontWeight(.medium)
                            .padding(24)
                    }
                    .onTapGesture {
                        let isEven = i % 2 == 0
                        moves[i] = isEven ? "xmark" : "circle"
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    GameView()
}

struct ScoreView: View {
    
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
                .stroke(Color(.label), lineWidth: 3)
        }
    }
}
