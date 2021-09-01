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
        static let publicKey = "_____your publicKey_____"
        static let privateKey = "_____your privateKey____"
        static let `protocol` = "https"
        static let version = "v1"
        static let port = "443"
        static let baseUrl = "\(`protocol`)://gateway.marvel.com:\(port)/\(version)/public/"
    }
}
