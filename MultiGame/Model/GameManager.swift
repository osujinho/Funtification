//
//  GameManager.swift
//  MultiGame
//
//  Created by Michael Osuji on 6/24/21.
//

import Foundation

final class GameManager: ObservableObject {
    private var isPlaying = false {
        didSet {
            isPlayingChanged?(isPlaying)
        }
    }
    
    private var firstMultipleArray = [Int]()
    private(set) var questionsArray = [Question]()
    
    private(set) var numberOfQuestions = 0
    
    var isPlayingChanged: ((Bool) ->())?
    
    func prepareGame(questionCount: Int, multipliers: [Int]) {
        firstMultipleArray.append(contentsOf: multipliers)
        self.numberOfQuestions = questionCount
        createQuestions()
        shuffleQuestionsArray()
        isPlaying.toggle()
    }
    
    
    // -------------------Function for the New Game button----
    func resetGame() {
        firstMultipleArray.removeAll()
        questionsArray.removeAll()
        isPlaying.toggle()
    }
    

    // ------------------Function to Create the questions------
    func createQuestions() {
        for first in firstMultipleArray {
            for second in 1...12 {
                let newQuestion = Question(question: "\(first) x \(second) =", questionAnswer: "\(first * second)")
                questionsArray.append(newQuestion)
            }
        }
    }
    
    // --------------------Function to shuffle the QuestionsArray-----
    func shuffleQuestionsArray() {
        questionsArray.shuffle()
    }
    
}
