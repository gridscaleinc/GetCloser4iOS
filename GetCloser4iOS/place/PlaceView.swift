//
//  PlaceView.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/04/26.
//  Copyright © 2020 gridscale. All rights reserved.
//

import Foundation
import SwiftUI
import StompClientKit
import Combine

struct PlaceView: View {

    
    @ObservedObject var contentManager = ContentManager()
    @State var input = InputContent()
    
    var body: some View {
        ZStack{
            Place()
            VStack {
                Spacer()
                InputBar(content: $input, {
                    self.handleInput()
                }).background(Color.white).border(Color.white, width: 0)
            }.padding()
            .KeyboardAwarePadding()
        }
    }
    
    func handleInput() {
        // if text
        if (self.input.resultType == .text) {
            contentManager.send(message: self.input.text)
        }
        
        // if audio
        
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView()
    }
}
