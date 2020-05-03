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

struct PlaceView: View {

    var stompclient : StompClient
    
    @ObservedObject var content = ContentModel()
    
    init() {
        stompclient = StompClient(endpoint: StompConfig.GETCLOSER_WS_ENDPOINT)
        stompclient.messageHandler = self.handleMessage
        stompclient.startConnect ( onConnected:  {
            client in
            client.subscribe(to: StompConfig.GETCLOSER_GEOTAG_TOPIC_PREFIX)
        })
//
    }
    
    var body: some View {
        ZStack {
            Place(text: $content.message)
            VStack {
                Spacer()
                    Text("Message: \(content.message)")
                HStack {
                    Spacer()
                    TextField("Message...", text: $content.message){
                        UIApplication.shared.endEditing()
                    }.border(Color.black)
                    Button(action:{
                        var message = HelloMessage()
                        message.name = self.content.message
                        self.stompclient.sendJson(message, to: "app/hello", contentType: "application/json")
                    }) {
                        Text("send")
                    }
                }
            }
        }
    }
    
    func handleMessage(frame: Frame)  {
        DispatchQueue.main.async {
            do {
                let dto = try JSONDecoder().decode(ContentDto.self, from: frame.body.data)
                self.content.message = dto.content
            } catch {
                
            }
                
        }
    }
}
