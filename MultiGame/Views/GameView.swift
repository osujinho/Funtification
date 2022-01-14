//
//  GameView.swift
//  MultiGame
//
//  Created by Michael Osuji on 4/23/21.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var model: GameViewModel
    
    var body: some View {
        VStack {
            // HStack for the Navigation Buttons
            HStack {
                // New Game Button
                Button(action: {
                    model.startOver()
                } ) {
                    HStack{
                        Image(systemName: "escape")
                        Text("Quit")
                    }.navButtonModifier()
                    .background(multiplierColor.cornerRadius(15))
                Spacer()
                }
                
                // Qestion Number TextBox
                Text("Question: \(model.nextQuestionNumber + 1) of \(model.numberOfQuestions)")
                .navButtonModifier()
            } .padding()
            Spacer()
            
            
            // Question and Answer TextBox HStack
            HStack {
                // Question TextBox
                
                Text("\(model.currentQuestion)")
                    .multiplierText()
                    .foregroundColor(questionColor)
                
                // Answer TextBox
                Text(model.answerText.isEmpty ? "?" : "\(model.answerText)")
                    .multiplierText()
                    .foregroundColor(model.answerTextColor)
                    .modifier(Shake(animatableData: CGFloat(model.wrongAnswerShakeAmount)))
                    .scaleEffect(CGFloat(model.correctAnswerAnimationAmount))
            }.padding()
            Spacer()
            
            // Keyboard View here
            KeyboardView(gameViewModel: model)
        }
        // Cannot have more than 1 alert on a view (VStack here) use a switch statement instead to accomplish this.
        
        .alert(isPresented: $model.showingAlert) { () -> Alert in
            model.wrongAnswerAlert()
        }
        .onAppear { model.showQuestion() }
        .onDisappear { model.resetGameView() }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(model: GameViewModel())
    }
}
