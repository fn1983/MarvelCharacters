//
//  CharacterTests.swift
//  MarvelCharactersTests
//
//  Created by Paul Soto on 2/9/21.
//

@testable import MarvelCharacters
import XCTest

class CharacterTests: XCTestCase {
    func testInitFromCustomDecoder() {
        let dataResult: Result<Character, Error> = JSONReader(
            bundle: .testingBundle
        ).objFromJson(withName: "character")
        switch dataResult {
        case .success(let character):
            XCTAssertTrue(character.id == 1009610)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
}
