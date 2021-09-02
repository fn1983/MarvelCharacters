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
    var isValidURL: Bool {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return false
        }
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
