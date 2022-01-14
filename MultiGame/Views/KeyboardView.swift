//
//  KeyboardView.swift
//  MultiGame
//
//  Created by Michael Osuji on 6/5/21.
//

import SwiftUI

struct KeyboardView: View {
    @ObservedObject var gameViewModel: GameViewModel
    @ObservedObject var model = KeyboardViewModel()
    
    var body: some View {
        VStack (alignment: .center, spacing: 20){
            ForEach(model.keypadRows) { keypadRow in
                HStack(spacing: model.getSpacing()) {
                    ForEach(keypadRow.row) { key in
                        Button(action: {
                            switch key.value {
                            case _ where (key.value == "Delete"):
                                if gameViewModel.answerText.count > 0 {
                                    gameViewModel.answerText.removeLast()
                                }
                            case _ where (key.value == "Submit"):
                                if gameViewModel.answerText.count > 0 {
                                    gameViewModel.submitAnswer()
                                }
                            default:
                                if gameViewModel.answerText.count < 3 { gameViewModel.answerText.append(key.value)
                                }
                            }
                        } ) {
                            switch key.value {
                            case _ where (key.value == "Delete"):
                                DeleteAndSubmitButtonView(model: gameViewModel, imageName: "delete.left.fill", buttonLabel: key.value)
                            case _ where (key.value == "Submit"):
                                DeleteAndSubmitButtonView(model: gameViewModel, imageName: "arrow.forward.square.fill", buttonLabel: key.value)
                            default:
                                Text(key.value).keypadButtonModifier()
                            }
                        }.disabled((gameViewModel.answerText.isEmpty) && (key.value == "Delete" || key.value == "Submit"))
                    }
                }
            }
        }
    }
}
