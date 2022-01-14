//
//  KeyboardViewModel.swift
//  MultiGame
//
//  Created by Michael Osuji on 6/17/21.
//

import SwiftUI

class KeyboardViewModel: ObservableObject {
    var keypadRows = [
        KeypadRow(id: 0, row: [Key(id: 0, value: "1"), Key(id: 1, value: "2"), Key(id: 2, value: "3")]),
        KeypadRow(id: 1, row: [Key(id: 0, value: "4"), Key(id: 1, value: "5"), Key(id: 2, value: "6")]),
        KeypadRow(id: 2, row: [Key(id: 0, value: "7"), Key(id: 1, value: "8"), Key(id: 2, value: "9")]),
        KeypadRow(id: 3, row: [Key(id: 0, value: "Delete"), Key(id: 1, value: "0"), Key(id: 2, value: "Submit")])
    ]
    
    // -----------------Function to get the gloat
    func getSpacing() -> CGFloat {
        UIScreen.main.bounds.width / 16
    }
}

struct KeypadRow: Identifiable {
    var id: Int
    var row: [Key]
}

struct Key: Identifiable {
    var id: Int
    var value: String
}
