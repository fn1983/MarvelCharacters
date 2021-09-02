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
        static let publicKey: String = {
            guard let keys = Bundle.main.object(forInfoDictionaryKey: "MarvelApiKeys") as? [String: String] else {
                return .init()
            }
            return keys["public"] ?? .init()
        }()
        static let privateKey: String = {
            guard let keys = Bundle.main.object(forInfoDictionaryKey: "MarvelApiKeys") as? [String: String] else {
                return .init()
            }
            return keys["private"] ?? .init()
        }()
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
