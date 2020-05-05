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
import AVFoundation
import NaturalLanguage

struct PlaceView: View {

    var stompclient : StompClient
    
    @ObservedObject var content = ContentModel()
    @State var input = InputContent()
    
    init() {
        stompclient = StompClient(endpoint: StompConfig.GETCLOSER_WS_ENDPOINT)
        stompclient.messageHandler = self.handleMessage
        stompclient.startConnect ( onConnected:  {
            client in
            client.subscribe(to: StompConfig.GETCLOSER_GEOTAG_TOPIC_PREFIX)
        })
    }
    
    var body: some View {
        ZStack{
            Place(text: $input.text)
            VStack {
                Spacer()
                InputBar(content: $input, {
                    if (self.input.text.count != 0) {
                        var message = HelloMessage()
                        message.name = self.content.message
                        self.stompclient.send(json: message, to: "/app/hello", contentType: "application/json")
                    }
                })
            }.padding()
            .KeyboardAwarePadding()
        }
    }
    
    func handleMessage(frame: Frame)  {
//        DispatchQueue.main.async {
//            do {
//                let dto = try JSONDecoder().decode(ContentDto.self, from: frame.body.data)
//                self.content.message = dto.content
//            } catch {
//
//            }
//
//        }
        do {
            let dto = try JSONDecoder().decode(ContentDto.self, from: frame.body.data)
            speech(text: dto.content)
        } catch {
            
        }
        
    }
    
    func speech(text: String ) {
        let language = NLLanguageRecognizer.dominantLanguage(for: text)
        if (language != nil) {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: language!.rawValue)
            utterance.rate = 0.5

            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }
        
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
