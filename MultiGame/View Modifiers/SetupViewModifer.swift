//
//  Views.swift
//  MultiGame
//
//  Created by Michael Osuji on 4/8/21.
//

import SwiftUI

//-----------------Number of Question stepper View Moidifier--------------------
struct StepperModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding()
            .border(multiplierColor, width: 1)
            .foregroundColor(.white)
    }
}

extension View {
    func stepperModifier() -> some View {
        self.modifier(StepperModifier())
    }
}



// --------------------Multiplier Button Composition---------------------
struct MultiplierButtonView: View {
    @ObservedObject var model: SetupViewModel
    
    let index: Int
    
    var body: some View {
        Button(action: {
            model.userSelectedAt(index: index)
        }) {
            Image(systemName: "\(model.multipliers[index].number).circle")
        }
        .foregroundColor(model.multipliers[index].isSelected ? paleWhite : Color.white)
        .font(Font.system(size: 60))
        .padding(2)
        .background(model.multipliers[index].isSelected ? paleMultiplierColor : multiplierColor)
        .clipShape(Capsule())
        .opacity(model.multipliers[index].isSelected ? 0.8 : 1.0)
        .scaleEffect(model.multipliers[index].isSelected ? 1.2 : 1)
        .animation(.easeOut(duration: 0.2))
    }
}

// ----------------Play and Restart Button Composition -------------
struct PlayAndRestartButton: View {
    @ObservedObject var model: SetupViewModel
    
    let imageName: String
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Image(systemName: "\(imageName)")
                Text("\(buttonText)")
            }
            
        }
        .foregroundColor(model.multiplierSelected ? Color.white : paleWhite)
        .font(.title)
        .padding()
        .background(model.multiplierSelected ? playAndRestartButtonColor : palePlayAndRestartButtonColor)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .opacity(model.multiplierSelected ? 1.0 : 0.8)
        .scaleEffect(model.multiplierSelected ? 1.1 : 1.0)
        .disabled(!model.multiplierSelected)
    }
}
