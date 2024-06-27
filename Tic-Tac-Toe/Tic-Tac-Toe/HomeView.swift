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
            
            Toggle("Single Player", isOn: $isSinglePlayer)
                .tint(.indigo)
                .font(.title3)
                .padding()
            
            Picker("Difficulty", selection: $selectedDifficulty) {
                ForEach(Difficulty.allCases) { difficulty in
                    Text(difficulty.rawValue.capitalized)
                }
            }
            .pickerStyle(.segmented)
            .disabled(!isSinglePlayer)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Game Start").frame(width: 280)
            }.modifier(TTButtonStyle())
        }
        .padding()
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
    }
}

#Preview {
    HomeView()
}
