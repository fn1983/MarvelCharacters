//
//  Constants.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//

import Foundation

struct Constants {
    private init() {}

    struct Api {
        static let publicKey = "______publicKey_______"
        static let privateKey = "______privateKey_______"
        static let `protocol` = "https"
        static let version = "v1"
        static let port = "443"
        static let baseUrl = "\(`protocol`)://gateway.marvel.com:\(port)/\(version)/public/"
    }
    
    struct Loading {
        static let delay = DispatchTimeInterval.milliseconds(300)
        static let minDisplayTime = DispatchTimeInterval.milliseconds(1000)
    }
}
