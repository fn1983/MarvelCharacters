//
//  Throwable.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 3/9/21.
//

import Foundation

struct Throwable<T: Decodable>: Decodable {
    let result: Result<T, Error>

    init(from decoder: Decoder) throws {
        self.result = Result(catching: { try T(from: decoder) })
    }
}
