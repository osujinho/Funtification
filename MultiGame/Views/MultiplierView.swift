//
//  MultiplierView.swift
//  MultiGame
//
//  Created by Michael Osuji on 5/19/21.
//

import SwiftUI

struct MultiplierView: View {
    @ObservedObject var model: SetupViewModel
    
    var body: some View {
        VStack {
            HStack {
                ForEach(0..<4) { index in
                    MultiplierButtonView(model: model, index: index)
                }
            }
            HStack {
                ForEach(4..<8) { index in
                    MultiplierButtonView(model: model, index: index)
                }
            }
            HStack {
                ForEach(8..<12) { index in
                    MultiplierButtonView(model: model, index: index)
                }
            }
        }
    }
}
