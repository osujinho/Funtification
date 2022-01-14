//
//  SetupView.swift
//  MultiGame
//
//  Created by Michael Osuji on 4/23/21.
//

import SwiftUI

struct SetupView: View {
    @ObservedObject var model: SetupViewModel
    
    var body: some View {
        VStack {
            
            Text("Choose The Tables")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
            
            // multiplier View Added here
            VStack(spacing: 10) {
                MultiplierView(model: model)
            }.padding()
           
            // Number of question picker
            VStack(alignment: .leading, spacing: 20) {
                Text("How many questions do you want?")
                
                Picker("Number of Questions", selection: $model.numberOfQuestionsPicker) {
                    ForEach(NumberOfQuestions.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
            .stepperModifier()
            .padding()
            
            // Play and reset button View added here
            HStack {
                PlayAndRestartButton(model: model, imageName: "play.fill", buttonText: "PLAY", action: model.playGame)
                
                Spacer()
                PlayAndRestartButton(model: model, imageName: "arrow.triangle.2.circlepath", buttonText: "RESET", action: model.resetSetupView)
            }.padding()
            
            
        }
        .onDisappear{ model.resetSetupView() }
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView(model: SetupViewModel())
    }
}
