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
    
    @State var msg: String = ""
    var stompclient : StompClient
    
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
            Place()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    TextField("Message...", text: $msg){
                        UIApplication.shared.endEditing()
                    }.border(Color.black)
                    Button(action:{}) {
                        Text("send")
                    }
                }
            }
        }
    }
    
    func handleMessage(frame: Frame)  {
        print(frame)
    }
}
