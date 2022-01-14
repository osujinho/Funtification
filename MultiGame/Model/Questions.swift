//
//  Questions.swift
//  MultiGame
//
//  Created by Michael Osuji on 4/22/21.
//

import Foundation

struct Question {
    var question: String
    var questionAnswer: String
}

enum NumberOfQuestions: String, CaseIterable {
    case five = "5"
    case ten = "10"
    case fifteen = "15"
    case twenty = "20"
    case all = "All"
    
    func getQuestionCount(multipliersCount: Int) -> Int {
        switch self {
        case .five: return 5
        case .ten:
            return 10
        case .fifteen:
            return 15
        case .twenty:
            return 20
        case .all:
            return multipliersCount * 12
        }
    }
}
