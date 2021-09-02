//
//  CharactersRepositoryTests.swift
//  MarvelCharactersTests
//
//  Created by Paul Soto on 2/9/21.
//

@testable import MarvelCharacters
import XCTest

class MeteoWarningsRepositoryTests: XCTestCase {
    func testWithoutError() {
        let sut = CharactersRepository(api: MockCharactersDataSource())

        let charactersExpect = XCTestExpectation(description: "wait testWithoutError")
        var charactersErrorSpy: Error?
        sut.fetchCharacters(offSet: 0, pageLimit: 21) { result in
            switch result {
            case .success(_):
                charactersErrorSpy = nil
            case .failure(let error):
                charactersErrorSpy = error
            }
            charactersExpect.fulfill()
        }
        
        let characterExpect = XCTestExpectation(description: "wait testWithoutError")
        var characterErrorSpy: Error?
        sut.fetchCharacter(withId: 74747) { result in
            switch result {
            case .success(_):
                characterErrorSpy = nil
            case .failure(let error):
                characterErrorSpy = error
            }
            characterExpect.fulfill()
        }
        
        self.wait(for: [charactersExpect, characterExpect], timeout: 30)
        XCTAssertNil(charactersErrorSpy)
        XCTAssertNil(characterErrorSpy)
    }

    func testWithError() {
        let sut = CharactersRepository(
            api: MockCharactersDataSourceWithError()
        )

        let charactersExpect = XCTestExpectation(description: "wait testWithError")
        var charactersErrorSpy: Error?
        sut.fetchCharacters(offSet: 0, pageLimit: 21) { result in
            switch result {
            case .success(_):
                charactersErrorSpy = nil
            case .failure(let error):
                charactersErrorSpy = error
            }
            charactersExpect.fulfill()
        }
        
        let characterExpect = XCTestExpectation(description: "wait testWithError")
        var characterErrorSpy: Error?
        sut.fetchCharacter(withId: 74747) { result in
            switch result {
            case .success(_):
                characterErrorSpy = nil
            case .failure(let error):
                characterErrorSpy = error
            }
            characterExpect.fulfill()
        }
        
        self.wait(for: [charactersExpect, characterExpect], timeout: 30)
        XCTAssertNotNil(charactersErrorSpy)
        XCTAssertNotNil(characterErrorSpy)
    }
}

private class MockCharactersDataSource: CharactersDataSource {
    func fetchCharacters(offSet: Int, pageLimit: Int, completion: @escaping (Result<CharactersResult, Error>) -> Void) {
        completion(.success((characters: [], totalMatches: 2)))
    }
    
    func fetchCharacter(withId id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        completion(.success(.init(
            id: 87478,
            name: "Lorem ipsum dolor sit amet",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris semper imperdiet lorem, eleifend rhoncus nibh scelerisque at. Pellentesque sollicitudin tortor eget porttitor rhoncus. Vivamus laoreet orci suscipit accumsan elementum. Vestibulum maximus nunc a odio tincidunt mattis.",
            thumbnail: "http://google.com"
        )))
    }
}

private class MockCharactersDataSourceWithError: CharactersDataSource {
    func fetchCharacters(offSet: Int, pageLimit: Int, completion: @escaping (Result<CharactersResult, Error>) -> Void) {
        completion(.failure(MarvelCharactersError.DataTransferError.noResponse))
    }
    
    func fetchCharacter(withId id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        completion(.failure(MarvelCharactersError.DataTransferError.noResponse))
    }
}
