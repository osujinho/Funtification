//
//  ContentView.swift
//  MultiGame
//
//  Created by Michael Osuji on 3/30/21.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var model = AppViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [gradientTopColor, gradientBottomColor]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                if model.isPlaying {
                    GameView(model: model.gameViewModel)
                } else {
                    SetupView(model: model.setupViewModel)
                }
            }
            // App title
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Funtification")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
