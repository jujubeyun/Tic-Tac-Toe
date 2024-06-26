//
//  HomeView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/25/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("👾 Tiki Taki 👾")
                .font(.system(size: 50, weight: .bold))
                
            Button {
                
            } label: {
                Text("Single Player").frame(width: 280)
            }.modifier(TTTButtonStyle())
            
            Button {
                
            } label: {
                Text("Two Players").frame(width: 280)
            }.modifier(TTTButtonStyle())
            
            Button {
                
            } label: {
                Text("Options").frame(width: 280)
            }.modifier(TTTButtonStyle())
        }
    }
}

#Preview {
    HomeView()
}
