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
            
            PlayerView(selectedPlayer: $vm.selectedPlayer)
            
            OptionView()
            
            Spacer()
            
            Button {
                vm.isPlaying = true
            } label: {
                Text("Game Start").frame(width: 280)
            }.modifier(TTButtonStyle())
        }
        .sheet(item: $vm.selectedPlayer) { player in
            switch player {
            case .player1:
                SymbolView(selectedPlayer: $vm.selectedPlayer)
                    .presentationDetents([.fraction(0.43)])
            case .player2:
                SymbolView(selectedPlayer: $vm.selectedPlayer)
                    .presentationDetents([.fraction(0.43)])
            }
        }
        .fullScreenCover(isPresented: $vm.isPlaying) {
            GameView()
        }
        .padding()
    }
}

#Preview {
    HomeView()
        .environment(GameSetting())
}
