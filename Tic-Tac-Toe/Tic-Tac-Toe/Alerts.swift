//
//  Alerts.swift
//  Tic-Tac-Toe
//
//  Created by Juhyun Yun on 7/22/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let player1Win   = AlertItem(title: Text("Player 1 Win!"),
                                 message: Text("Player 1 is smarter"),
                                 buttonTitle: Text("OK"))
    
    static let player2Win   = AlertItem(title: Text("Player 2 Win!"),
                                 message: Text("Player 2 is smarter."),
                                 buttonTitle: Text("OK"))
    
    static let draw         = AlertItem(title: Text("Draw"),
                                 message: Text("What a battle of wits we have here..."),
                                 buttonTitle: Text("Try Again"))
}

