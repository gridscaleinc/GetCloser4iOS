//
//  Content.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/05/02.
//  Copyright © 2020 gridscale. All rights reserved.
//

import Foundation

public class ContentModel: ObservableObject {
    @Published public var message = ""
}

public class ContentDto: Codable {
    var content: String
}
