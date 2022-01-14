//
//  SetupViewModel.swift
//  MultiGame
//
//  Created by Michael Osuji on 6/17/21.
//

import Foundation

class SetupViewModel: ObservableObject {
    
    @Published var multipliers = Array(1...12).map { Multiplier(number: $0, isSelected: false) }
    
    var multiplierSelected: Bool {
        multipliers.first(where: {$0.isSelected}) != nil
    }
    
    @Published var numberOfQuestionsPicker: NumberOfQuestions = .five
    var numberOfQuestions: Int {
        numberOfQuestionsPicker.getQuestionCount(multipliersCount: selectedMultipliers.count)
    }
    
    var selectedMultipliers = [Int]()
    
    var prepareGame: ((Int, [Int]) -> ())?
    
    // -------------------Function to toggle the multiplier buttons------
    func userSelectedAt(index: Int) {
        multipliers[index].isSelected.toggle()
    }
    
    // --------------------Function for the Play Button-------------
    func playGame() {
        selectedMultipliers = multipliers.filter { $0.isSelected }.map { $0.number }
        prepareGame?(numberOfQuestions, selectedMultipliers)
    }
    
    // -------------------Function to Reset the Multiplier buttons ---
    func resetMultipliers() {
        for index in 0..<multipliers.count where multipliers[index].isSelected {
            multipliers[index].isSelected.toggle()
        }
    }
    
    // ---------------Function to reset the setupView Screen--------
    func resetSetupView() {
        resetMultipliers()
        numberOfQuestionsPicker = .five
    }
}
