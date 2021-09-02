//
//  FetchCharactersDTOTests.swift
//  MarvelCharactersTests
//
//  Created by Paul Soto on 2/9/21.
//

@testable import MarvelCharacters
import XCTest

class FetchCharactersDTOTests: XCTestCase {
    func testInitFromCustomDecoder() {
        let dataResult: Result<FetchCharactersDTO.Result, Error> = JSONReader(
            bundle: .testingBundle
        ).objFromJson(withName: "characters")
        switch dataResult {
        case .success(let characters):
            XCTAssertTrue(characters.characters.count > 0)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
    }
}

