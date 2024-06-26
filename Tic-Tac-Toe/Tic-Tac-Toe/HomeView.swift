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

struct HomeView: View {
    
    @State var isSinglePlayer = true
    @State var selectedDifficulty: Difficulty = .easy
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("👾 Tiki Taki 👾")
                .font(.system(size: 50, weight: .bold))
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "face.smiling")
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
                    
                } label: {
                    Image(systemName: "heart")
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
    }
}

#Preview {
    HomeView()
}
