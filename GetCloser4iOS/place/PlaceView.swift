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

    var stompclient : StompClient
    
    @ObservedObject var content = ContentModel()
    
    @State private var keyboardHeight: CGFloat = 10
    
    init() {
        stompclient = StompClient(endpoint: StompConfig.GETCLOSER_WS_ENDPOINT)
        stompclient.messageHandler = self.handleMessage
        stompclient.startConnect ( onConnected:  {
            client in
            client.subscribe(to: StompConfig.GETCLOSER_GEOTAG_TOPIC_PREFIX)
        })
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
                        self.stompclient.send(json: message, to: "/app/hello", contentType: "application/json")
                    }) {
                        Text("send")
                    }
                }
            }.padding(.bottom, keyboardHeight)
            .onReceive(Publishers.keyboardHeight) {
                self.keyboardHeight = ($0==0) ? 10 : $0
                
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

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceView()
    }
}
