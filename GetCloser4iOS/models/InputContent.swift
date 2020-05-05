//
//  InputContent.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/05/05.
//  Copyright © 2020 gridscale. All rights reserved.
//

import Foundation

struct InputContent {
    var type: ContentType = .text
    var resultType : ContentType = .text
    
    var text: String = ""
    
    init() {
        
    }
    
    enum ContentType {
        case text
        case voice
        case image
        case video
    }
}

