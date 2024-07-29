//
//  Alerts.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 7/22/24.
//

import Foundation

enum AlertType {
    case win(player: Player), draw, reset, exit
    
    var title: String {
        switch self {
        case .win(let player):
            "\(player.rawValue.capitalized) Win"
        case .draw:
            "Draw"
        case .reset:
            "Reset Game"
        case .exit:
            "Exit Game"
        }
    }
    
    var message: String {
        switch self {
        case .win(let player):
            "\(player.rawValue.capitalized) is so smart!"
        case .draw:
            "What a battle of wits we have here.."
        case .reset, .exit:
            "Are you sure?"
        }
    }
}
