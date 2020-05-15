//
//  Content.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/05/02.
//  Copyright © 2020 gridscale. All rights reserved.
//

import Foundation
import StompClientKit
import AVFoundation
import NaturalLanguage
import SwiftUI

/**
 *
 */
public class ContentManager: ObservableObject {
    var stompclient : StompClient
    
    init() {
        stompclient = StompClient(endpoint: StompConfig.GETCLOSER_WS_ENDPOINT)
        _ = stompclient.startConnect ( onConnected:  {
            client in
            var subscription = client.subscribe(to: StompConfig.GETCLOSER_GEOTAG_TOPIC_PREFIX)
            subscription.messageHandler = self.handleMessage
        })
        

    }
    
    @Published public var message = "hello"
    
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
            let dto = try JSONDecoder().decode(MimeContent.self, from: frame.body)
            speech(text: dto.content)
        } catch {
            
        }
        
    }
    
    /// send message
    /// - Parameter message: message to be sent
    func send (message: String) {
        var hello = HelloMessage()
        hello.name = message
        stompclient.send(json: hello, to: "/app/hello", using: .utf8, contentType: "application/json")
    }
    
    /// text to speech
    /// - Parameter text: the text to be convert ot speech.
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

/**
 *
 */
public class MimeContent: Codable {
    
    var content: String
}

