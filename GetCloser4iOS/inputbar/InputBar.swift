//
//  InputBar.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/05/05.
//  Copyright © 2020 gridscale. All rights reserved.
//

import Foundation
import SwiftUI

struct InputBar : View {
    @Binding private var content : InputContent
    @State var voiceInput = VoiceRecorder()
    
    var onCommit : () -> Void = {}
    
    init(content store: Binding<InputContent>, _ onCommit: @escaping ()->Void = {}) {
        _content = store
        self.onCommit =  onCommit
    }
    
    var body : some View {
        HStack {
            if (content.type == . text) {
                Button(action:{
                    self.content.type = .voice
                }){
                    Image(systemName: "mic.circle").imageScale(.large).foregroundColor(.black)
                }
            } else {
               Button(action:{
                   self.content.type = .text
               }){
                   Image(systemName: "keyboard").imageScale(.large).foregroundColor(.black)
               }
            }
            Spacer()
            if (content.type == .text) {
                TextField("メッセージ...", text: $content.text) {
                    UIApplication.shared.endEditing()
                }.padding(5)
                    .font(Font.system(size: 18, weight: .medium, design: .serif))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            } else {
                TapCircle(onceTapped:{ date in
                    print("Start Recording....." + date.description)
                    self.voiceInput.startRecording()
                },
                          twiceTapped: {date in
                            print("Stop Recording....." + date.description)
                            self.voiceInput.finishRecording(success: true)
                }
                ).frame(width: 50, height: 50, alignment: .center)
            }
            Spacer()
            Image(systemName: "plus.app").imageScale(.large).foregroundColor(.black)
        }
    }
}

struct InputBar_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
