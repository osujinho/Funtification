//
//  GameViewModel.swift
//  MultiGame
//
//  Created by Michael Osuji on 6/17/21.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var gameManager = GameManager()
    
    @Published var nextQuestionNumber = 0
    @Published var score = 0
    
    @Published var showingAlert = false
    @Published var activeAlert: ActiveAlert = .end
    
    @Published var currentQuestion = "1 x 1 ="
    @Published var answer = ""
    @Published var answerText = ""
    
    @Published var answerTextColor = answerColor
    @Published var wrongAnswerShakeAmount = 0
    @Published var correctAnswerAnimationAmount = 1.0
    
    
    var isPlayingChanged: ((Bool) -> ())?
    
    var numberOfQuestions: Int {
        return gameManager.numberOfQuestions
    }
    
    init() {
        gameManager.isPlayingChanged = { isPlaying in
            self.isPlayingChanged?(isPlaying)
        }
    }
    
    // ------------------Function to Update the score
    func updateScore() {
        if answerText == answer {
            score += 1
        }
    }
    
    // -----------------Function for Submit Button------------------
    func submitAnswer() {
        answerTextColorFunction()
        answerText == answer ? correctAnswer() : wrongAnswer()
    }
    
    // -----------------Function to end the game------------------
    func endGame() {
        self.showingAlert.toggle()
    }
    
    // -----------------Function to try again after getting a wrong answer------------------
    func tryAgain() {
        answerText = ""
        answerTextColor = answerColor
        activeAlert = .end
    }
    
    // -----------------Function to change the answer text color------------------
    func answerTextColorFunction() {
        switch answerText{
        case _ where (!answerText.isEmpty && answerText != answer):
            return answerTextColor = Color.red
        case _ where (!answerText.isEmpty && answerText == answer):
            return answerTextColor = Color.green
        default:
            return answerTextColor = answerColor
        }
    }
    
    // -----------------Function to switch alert-----------------
    func switchAlert() {
        self.showingAlert = true
        
        switch activeAlert {
        
        case .wrong:
            self.activeAlert = .end
        case .end:
            self.activeAlert = .wrong
        }
    }
    
    // -----------------Function to display the wrong Answer Alert------------------
    func wrongAnswerAlert() -> Alert {
        switch activeAlert {
        
        case .wrong:
            let primaryButton = Alert.Button.default(Text("Try Again"),
                                                    action: {
                                                        DispatchQueue.main.async {
                                                            self.tryAgain()
                                                        }
                                                    })
            let secondaryButton = Alert.Button.destructive (Text((nextQuestionNumber + 1) >= numberOfQuestions ? "End Game" : "Next Question"),
                                                            action: {
                                                                DispatchQueue.main.async {
                                                                    self.wrongAnswerSecondaryButton()
                                                                }
                                                            })
            return Alert(title: Text("WRONG ANSWER"),
                         message: Text((currentQuestion.dropLast()) + "DOES NOT EQUAL " + (answerText)),
                         primaryButton: primaryButton, secondaryButton: secondaryButton)
        case .end:
            let primaryButton = Alert.Button.default(Text("Play Again"),
                                                     action: {
                                                        DispatchQueue.main.async {
                                                            self.startOver()
                                                        }
                                                     })
            return Alert(title: Text("GAME OVER!"),
                         message: Text("Your final score is \(score) out of \(numberOfQuestions) questions"),
                         dismissButton: primaryButton
                         )
        }
    }
    
    // -----------------Function for the wrong answer alert secondary button------------------
    func wrongAnswerSecondaryButton() {
        switch nextQuestionNumber {
        case _ where ((nextQuestionNumber + 1) >= numberOfQuestions):
            self.switchAlert()
        default:
            self.continuePlayingGame()
            activeAlert = .end
        }
    }
    
    // -----------------Function for wrong Answer Animation------------------
    func wrongAnswerAnimation() {
        wrongAnswerShakeAmount = 0
        withAnimation(.default) {
            wrongAnswerShakeAmount += 1
        }
    }
    
    // -----------------Function for wrong answer------------------
    func wrongAnswer() {
        wrongAnswerAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.switchAlert()
        })
    }
    
    // -----------------Function for the correct answer Animation------------------
    func correctAnswerAnimation() {
        correctAnswerAnimationAmount = 1.0
        withAnimation(.easeInOut(duration: 1)) {
            self.correctAnswerAnimationAmount = 2.0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            withAnimation(.easeInOut(duration: 1)) {
                self.correctAnswerAnimationAmount = 0.0
            }
        })
    }
    
    // -----------------Function for the correct answer------------------
    func correctAnswer() {
        updateScore()
        correctAnswerAnimation()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            self.correctAnswerAnimationAmount = 1.0
            self.continuePlayingGame()
        })
    }
    
    // -----------------Function to continue playing the game after getting an answer correct------------------
    func continuePlayingGame() {
        answerText = ""
        answerTextColor = answerColor
        
        nextQuestionNumber += 1
        showQuestion()
    }
    
    // Function to show the next question.
    func showQuestion() {
        currentQuestion = gameManager.questionsArray[nextQuestionNumber].question
        answer = gameManager.questionsArray[nextQuestionNumber].questionAnswer
    }
    
    func resetGameView() {
        answer = ""
        nextQuestionNumber = 0
        currentQuestion = "1 x 1 ="
        answerText = ""
        answerTextColor = answerColor
    }
    
    func startOver() {
        gameManager.resetGame()
    }
}

