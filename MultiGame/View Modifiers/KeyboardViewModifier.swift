//
//  KeyboardViewModifier.swift
//  MultiGame
//
//  Created by Michael Osuji on 6/17/21.
//

import SwiftUI

// -------Number buttons----------
struct KeypadButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(Font.system(size: 30, weight: .semibold))
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 10, leading: 45, bottom: 10, trailing: 45))
            //.frame(width: 100)
            .background(keypadButtonColor.cornerRadius(10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(keypadButtonColor, lineWidth: 1))
    }
}

extension View {
    func keypadButtonModifier() -> some View {
        self.modifier(KeypadButtonModifier())
    }
}

// --------------------Delete and Submit Button View Composition---------------------
struct DeleteAndSubmitButtonView: View {
    @ObservedObject var model: GameViewModel
    
    let imageName: String
    let buttonLabel: String
    
    var body: some View {
        HStack {
            if buttonLabel == "Delete" {
                Image(systemName: imageName)
                Text(buttonLabel)
            } else {
                Text(buttonLabel)
                Image(systemName: imageName)
            }
        }
        .font(.body)
        .foregroundColor(model.answerText.isEmpty ? paleWhite : Color.white)
        .padding(EdgeInsets(top: 18, leading: 13, bottom: 18, trailing: 13))
        //.frame(width: 100)
        .background(model.answerText.isEmpty ? Color.clear.cornerRadius(10) : (buttonLabel == "Delete" ? deleteButtonColor.cornerRadius(10) : submitButtonColor.cornerRadius(10)))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(model.answerText.isEmpty ? (buttonLabel == "Delete" ? paleDeleteButtonColor : paleSubmitButtonColor) : (buttonLabel == "Delete" ? deleteButtonColor : submitButtonColor), lineWidth: 1))
        .opacity(model.answerText.isEmpty ? 0.8 : 1.0)
    }
    
}
