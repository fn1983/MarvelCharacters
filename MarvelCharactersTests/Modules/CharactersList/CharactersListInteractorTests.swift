//
//  CharactersListInteractorTests.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 2/9/21.
//  Copyright (c) 2021. All rights reserved.
//

@testable import MarvelCharacters
import XCTest

class CharactersListInteractorTests: XCTestCase {
    private let spy = MockCharactersListPresenter()

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testFetchCharacters() {
        self.spy.expectation = self.expectation(description: "waitFetchCharacters")
        
        // MARK: Subject under test
        let sut = CharactersListInteractor(
            presenter: self.spy,
            router: MockCharactersListRouter(),
            repository: MockCharactersRepository()
        )

        // When
        sut.fetchCharacters(request: .init())
        self.waitForExpectations(timeout: 60, handler: nil)

        // Then
        XCTAssertTrue(self.spy.presentCharactersCalled, "\(#function) should ask the presenter to format the result")
    }
    
    func testFetchCharactersFailure() {
        self.spy.expectation = self.expectation(description: "waitFetchCharacters")
        
        // MARK: Subject under test
        let sut = CharactersListInteractor(
            presenter: self.spy,
            router: MockCharactersListRouter(),
            repository: MockCharactersFailureRepository()
        )

        // When
        sut.fetchCharacters(request: .init())
        self.waitForExpectations(timeout: 60, handler: nil)

        // Then
        XCTAssertTrue(self.spy.presentErrorCalled, "\(#function) should ask the presenter to format the result")
    }
}

private final class MockCharactersFailureRepository: CharactersRepositoryLogic {
    func fetchCharacters(offSet: Int, pageLimit: Int, completion: @escaping (Result<CharactersResult, Error>) -> Void) {
        completion(.failure(MarvelCharactersError.General.unexpected))
    }
    
    func fetchCharacter(withId id: Int, completion: @escaping (Result<Character, Error>) -> Void) {}
}

private final class MockCharactersRepository: CharactersRepositoryLogic {
    func fetchCharacters(offSet: Int, pageLimit: Int, completion: @escaping (Result<CharactersResult, Error>) -> Void) {
        completion(.success((characters: [], totalMatches: 2)))
    }
    
    func fetchCharacter(withId id: Int, completion: @escaping (Result<Character, Error>) -> Void) {}
}

private final class MockCharactersListRouter: CharactersListRouterLogic {
    func route(_ destination: CharactersList.Routing) {}
}

private final class MockCharactersListPresenter: CharactersListPresentationLogic {
    var viewController: CharactersListDisplayLogic?
    var expectation: XCTestExpectation?

    var presentCharactersCalled = false
    var presentErrorCalled = false

    func presentCharacters(response: CharactersList.Fetch.Response) {
        self.presentCharactersCalled = true
        self.expectation?.fulfill()
    }
    
    func presentError(response: CharactersList.Error.Response) {
        self.presentErrorCalled = true
        self.expectation?.fulfill()
    }
}
