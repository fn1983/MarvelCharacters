//
//  CharactersApiDataSourceTests.swift
//  MarvelCharactersTests
//
//  Created by Paul Soto on 2/9/21.
//

@testable import MarvelCharacters
import XCTest
import Hippolyte

class CharactersApiDataSourceTests: XCTestCase {
    override func tearDown() {
        super.tearDown()
        Hippolyte.shared.clearStubs()
    }

    func testFetchCharacters() {
        // Variables
        var error: Error?
        var characters: [Character]?
        
        let offSet = 0
        let pageLimit = 21

        let stubResponse = StubResponse.Builder()
            .stubResponse(withStatusCode: 200)
            .addBodyWithFileName(fileName: "characters")
            .addHeader(withKey: "content-type", value: "application/json")
            .build()

        guard let regex = try? NSRegularExpression(pattern: #"https://gateway.marvel.com:443/v1/public/characters\?((.*=.*)(&?))+"#, options: []) else {
            XCTFail("The regex is not valid in \(#function)")
            return
        }

        let stubRequest = StubRequest.Builder()
            .stubRequest(withMethod: .GET, urlMatcher: RegexMatcher(regex: regex))
            .addResponse(stubResponse)
            .build()

        Hippolyte.shared.add(stubbedRequest: stubRequest)
        Hippolyte.shared.start()

        let sut = CharactersApiDataSource()
        let expectation = XCTestExpectation(description: "wait testAPIDataSource")
        
        sut.fetchCharacters(offSet: offSet, pageLimit: pageLimit) { result in
            switch result {
            case .success(let result):
                characters = result.characters
                expectation.fulfill()
            case .failure(let err):
                error = err
                expectation.fulfill()
            }
        }

        self.wait(for: [expectation], timeout: 30)

        XCTAssertNotNil(characters)
        XCTAssertNil(error)
    }

    func testFetchCharacter() {
        // Variables
        var error: Error?
        var character: Character?

        let stubResponse = StubResponse.Builder()
            .stubResponse(withStatusCode: 200)
            .addBodyWithFileName(fileName: "characters")
            .addHeader(withKey: "content-type", value: "application/json")
            .build()

        guard let regex = try? NSRegularExpression(pattern: #"https://gateway.marvel.com:443/v1/public/characters/1009610\?((.*=.*)(&?))+"#, options: []) else {
            XCTFail("The regex is not valid in \(#function)")
            return
        }

        let stubRequest = StubRequest.Builder()
            .stubRequest(withMethod: .GET, urlMatcher: RegexMatcher(regex: regex))
            .addResponse(stubResponse)
            .build()

        Hippolyte.shared.add(stubbedRequest: stubRequest)
        Hippolyte.shared.start()

        let sut = CharactersApiDataSource()
        let expectation = XCTestExpectation(description: "wait testAPIDataSource")
        
        sut.fetchCharacter(withId: 1009610) { result in
            switch result {
            case .success(let result):
                character = result
                expectation.fulfill()
            case .failure(let err):
                error = err
                expectation.fulfill()
            }
        }

        self.wait(for: [expectation], timeout: 30)

        XCTAssertNotNil(character)
        XCTAssertNil(error)
    }
}
