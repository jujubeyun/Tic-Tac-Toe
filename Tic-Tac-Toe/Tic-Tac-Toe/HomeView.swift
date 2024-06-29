//
//  HomeView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/25/24.
//

import SwiftUI

struct HomeView: View {
    
    @Bindable var vm = HomeViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("👾 Tiki Taki 👾")
                .font(.system(size: 50, weight: .bold))
            
            PlayerView(selectedPlayer: $vm.selectedPlayer,
                       player1Symbol: $vm.player1Symbol,
                       player2Symbol: $vm.player2Symbol)
            
            OptionView(isSinglePlayer: $vm.isSinglePlayer,
                       selectedDifficulty: $vm.selectedDifficulty)
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Game Start").frame(width: 280)
            }.modifier(TTButtonStyle())
        }
        .sheet(item: $vm.selectedPlayer) { player in
            switch player {
            case .player1:
                SymbolView(selectedPlayer: $vm.selectedPlayer, 
                           symbol: $vm.player1Symbol)
                    .presentationDetents([.fraction(0.43)])
            case .player2:
                SymbolView(selectedPlayer: $vm.selectedPlayer, 
                           symbol: $vm.player2Symbol)
                    .presentationDetents([.fraction(0.43)])
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
