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
            LazyVGrid(columns: columns) {
                ForEach(0..<9) { i in
                    ZStack {
                        Rectangle()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.indigo.gradient)
                            .opacity(0.3)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
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
