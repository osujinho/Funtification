//
//  GameViewModifier.swift
//  MultiGame
//
//  Created by Michael Osuji on 6/17/21.
//

import SwiftUI

// -------------Navigation Button Modifiers-------------------
struct NavButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.white)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(multiplierColor, lineWidth: 2.0)
                    .shadow(color: multiplierColor, radius: 5, x: 2, y: 2)
            )
    }
}

extension View {
    func navButtonModifier() -> some View {
        self.modifier(NavButtonModifier())
    }
}

//----------------Question TextField-------------------
struct MultiplierText: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 70))
    }
}

extension View {
    func multiplierText() -> some View {
        self.modifier(MultiplierText())
    }
}


// -----------Answer textField----------------
struct AnswerText: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .font(Font.system(size: 20, weight: .medium, design: .serif))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.clear, lineWidth: 1))
    }
}

extension View {
    func answerText() -> some View {
        self.modifier(AnswerText())
    }
}

