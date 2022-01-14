//
//  AppViewModel.swift
//  MultiGame
//
//  Created by Michael Osuji on 6/24/21.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var setupViewModel = SetupViewModel()
    @Published var gameViewModel = GameViewModel()
    
    @Published var isPlaying = false
    
    init() {
        setupViewModel.prepareGame = { questionCount, multipliers in
            self.gameViewModel.gameManager.prepareGame(questionCount: questionCount, multipliers: multipliers)
        }
        
        gameViewModel.isPlayingChanged = { isPlaying in
            self.isPlaying = isPlaying
        }
    }
}
