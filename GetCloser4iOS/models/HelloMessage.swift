//
//  HelloMessage.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/05/03.
//  Copyright © 2020 gridscale. All rights reserved.
//

import Foundation
import StompClientKit

struct HelloMessage: StompMessage, Codable {
    var name: String = ""
    
    func fromText(text data: String, using encoding: String.Encoding) throws -> StompMessage {
        return HelloMessage()
    }
    
    func fromJson(json data: String, using encoding: String.Encoding = .utf8) throws -> StompMessage {
        return try JSONDecoder().decode(HelloMessage.self, from: data.data(using: encoding)!)
    }
    
    func toText() -> String {
        return ""
    }
    
    func toJson() -> String {
        return ""
    }
    
    
}
