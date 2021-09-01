//
//  String+Extensions.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        let digest = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return digest.reduce("") { (res: String, element) in
            let hex = String(format: "%02x", element)
            return res + hex
        }
    }
}
