//
//  SymbolView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/26/24.
//

import SwiftUI

struct SymbolView: View {
    
    let symbols = ["xmark", "circle", "pencil", "eraser", "folder", "arrowshape.left", "arrowshape.right", "arrowshape.up", "arrowshape.down", "person", "dumbbell", "power", "sun.max", "moon", "cloud", "snowflake", "tornado", "drop", "flame", "infinity", "square", "triangle", "diamond", "heart", "rhombus", "shield", "bolt", "camera", "bag", "cart", "creditcard", "die.face.3", "house", "lightbulb.max", "fan.desk", "balloon", "bed.double", "lock", "wifi", "headphones", "car", "horn", "bandage", "syringe", "facemask", "pill", "cross", "cross.vial", "hare", "tortoise", "dog", "cat", "lizard", "bird", "ant", "ladybug", "fish", "pawprint", "tree", "face.smiling", "eye", "hand.raised", "hand.thumbsup", "gamecontroller", "carrot", "atom", "gift", "plus", "minus", "arrow.left", "arrow.right", "arrow.up", "arrow.down", "dollarsign", "yensign", "eurosign", "wonsign"]
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 5)
    
    @Binding var selectedPlayer: Player?
    @Environment(GameSetting.self) private var gameSetting
    
    var body: some View {
        VStack {
            HStack() {
                Text("Symbol")
                    .font(.title2)
                
                Spacer()
                
                Button {
                    selectedPlayer = nil
                } label: {
                    XDismissButton()
                }
                
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(symbols, id: \.self) { symbol in
                        Button {
                            switch selectedPlayer {
                            case .player1:
                                gameSetting.player1Symbol = symbol
                            default:
                                gameSetting.player2Symbol = symbol
                            }
                        } label: {
                            Image(systemName: symbol)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 44, height: 44)
                                .tint(Color(.label))
                        }
                    }
                }
            }
        }
        .padding()
        .ignoresSafeArea()
    }
    
}


#Preview {
    SymbolView(selectedPlayer: .constant(.player1))
        .environment(GameSetting())
}


