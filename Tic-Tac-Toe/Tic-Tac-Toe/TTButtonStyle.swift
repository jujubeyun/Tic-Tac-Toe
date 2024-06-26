//
//  TTTButtonStyle.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 6/26/24.
//

import SwiftUI

struct TTButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .controlSize(.large)
            .tint(.indigo)
            .font(.title2)
    }
}
