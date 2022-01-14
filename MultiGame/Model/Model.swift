//
//  Model.swift
//  MultiGame
//
//  Created by Michael Osuji on 3/30/21.
//

import Foundation

enum ActiveAlert: String {
    case wrong, end

    var name: String {
        return self.rawValue
    }
}

struct Multiplier {
    let number: Int
    var isSelected: Bool
}
