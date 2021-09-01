//
//  Date+Extensions.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//

import Foundation

extension Date {
    var currentTimeInMillis: Int64 {
        Int64(self.timeIntervalSince1970 * 1000)
    }
}
