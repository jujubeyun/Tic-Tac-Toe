//
//  XDismissButton.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/27/24.
//

import SwiftUI

struct XDismissButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color(.secondarySystemFill))
                .opacity(0.6)
            
            Image(systemName: "xmark")
                .imageScale(.small)
                .frame(width: 44, height: 44)
                .foregroundStyle(Color(.secondaryLabel))
                .bold()
        }
    }
}

#Preview {
    XDismissButton()
}
