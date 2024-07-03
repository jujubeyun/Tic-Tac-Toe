//
//  GameSquareView.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 7/2/24.
//

import SwiftUI

struct GameSquareView: View {
    
    let imageName: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.indigo.gradient)
                .opacity(0.5)
            
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .fontWeight(.medium)
                .frame(width: 60)
        }
    }
}


#Preview {
    GameSquareView(imageName: "xmark")
}

