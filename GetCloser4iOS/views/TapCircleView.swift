//
//  TapCircleView.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/05/06.
//  Copyright © 2020 gridscale. All rights reserved.
//

import Foundation
import SwiftUI

struct TapCircle: View {
    @State var tapped = false
    
    var onOnceTapped : (_ time: Date)->Void
    var onTwiceTapped : (_ time: Date)-> Void
    
    init(onceTapped:@escaping(_ time: Date)->Void = {_ in } ,
         twiceTapped: @escaping(_ time: Date) -> Void = {_ in}) {
        onOnceTapped = onceTapped
        onTwiceTapped = twiceTapped
    }
    
    var tap: some Gesture {
        TapGesture(count: 1)
            .onEnded { _ in
                if self.tapped {
                    self.onTwiceTapped(Date())
                } else {
                    self.onOnceTapped(Date())
                }
                self.tapped.toggle()
        }
    }
    
    var body: some View {
        ZStack {
            Circle().fill(self.tapped ? Color.red : Color.blue)
            Image(systemName: (self.tapped ? "mic.circle.fill" : "mic.circle")).gesture(tap).imageScale(.large)
        }
    }
}

struct TapCircleView_Previews: PreviewProvider {
    static var previews: some View {
        TapCircle()
    }
}
