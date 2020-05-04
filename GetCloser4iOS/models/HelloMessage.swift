//
//  HelloMessage.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/05/03.
//  Copyright © 2020 gridscale. All rights reserved.
//

import Foundation
import StompClientKit

/// HellMessage
/// 挨拶文の内容を格納。
struct HelloMessage: StompMessage, Codable {
    var name: String = ""
    
    /// テキストからオブジェクトへ変換。
    ///
    /// - Parameters:
    ///   - data: <#data description#>
    ///   - encoding: <#encoding description#>
    /// - Throws: <#description#>
    /// - Returns: <#description#>
    func fromText(text data: String, using encoding: String.Encoding) throws -> StompMessage {
        return HelloMessage()
    }
    
    func fromJson(json data: String, using encoding: String.Encoding = .utf8) throws -> StompMessage {
        return try JSONDecoder().decode(HelloMessage.self, from: data.data(using: encoding)!)
    }
    
    /**
     * 文字列を返す。
     */
    func toText() -> String {
        return name
    }
    
    /// オブジェクトをJSONへ変換。
    ///
    /// - Returns: このオブジェクトのJSON形の文字列。
    func toJson() -> String {
        let js = try! JSONEncoder().encode(self)
        return String(data: js, encoding: .utf8) ?? ""
    }
}
