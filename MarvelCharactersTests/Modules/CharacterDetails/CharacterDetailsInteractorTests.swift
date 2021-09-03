//
//  CharacterDetailsInteractorTests.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 2/9/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import MarvelCharacters
import XCTest

class CharacterDetailsInteractorTests: XCTestCase {
    private let spy = MockCharacterDetailsPresenter()

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func testFetchCharacter() {
        self.spy.expectation = self.expectation(description: "waitFetchCharacter")
        
        // MARK: Subject under test
        let sut = CharacterDetailsInteractor(
            id: 6746467,
            presenter:  self.spy,
            router: MockCharacterDetailsRouter(),
            repository: MockCharacterRepository()
        )

        // When
        sut.fetchCharacter(request: .init())
        self.waitForExpectations(timeout: 60, handler: nil)

        // Then
        XCTAssertTrue(self.spy.presentCharacterCalled, "\(#function) should ask the presenter to format the result")
    }
    
    func testFetchCharactersFailure() {
        self.spy.expectation = self.expectation(description: "waitFetchCharacter")
        
        // MARK: Subject under test
        let sut = CharacterDetailsInteractor(
            id: 6746467,
            presenter:  self.spy,
            router: MockCharacterDetailsRouter(),
            repository: MockCharacterFailureRepository()
        )

        // When
        sut.fetchCharacter(request: .init())
        self.waitForExpectations(timeout: 60, handler: nil)

        // Then
        XCTAssertTrue(self.spy.presentErrorCalled, "\(#function) should ask the presenter to format the result")
    }
}

private final class MockCharacterFailureRepository: CharactersRepositoryLogic {
    func fetchCharacters(offSet: Int, pageLimit: Int, completion: @escaping (Result<CharactersResult, Error>) -> Void) {}
    
    func fetchCharacter(withId id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        completion(.failure(MarvelCharactersError.General.unexpected))
    }
}

private final class MockCharacterRepository: CharactersRepositoryLogic {
    func fetchCharacters(offSet: Int, pageLimit: Int, completion: @escaping (Result<CharactersResult, Error>) -> Void) {}
    
    func fetchCharacter(withId id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        completion(.success(.init(
            id: 87478,
            name: "Lorem ipsum dolor sit amet",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris semper imperdiet lorem, eleifend rhoncus nibh scelerisque at. Pellentesque sollicitudin tortor eget porttitor rhoncus. Vivamus laoreet orci suscipit accumsan elementum. Vestibulum maximus nunc a odio tincidunt mattis.",
            thumbnail: "http://google.com",
            urls: []
        )))
    }
}

private final class MockCharacterDetailsRouter: CharacterDetailsRouterLogic {
    func route(_ destination: CharacterDetails.Routing) {}
}

private final class MockCharacterDetailsPresenter: CharacterDetailsPresentationLogic {
    var viewController: CharacterDetailsDisplayLogic?
    var expectation: XCTestExpectation?

    var presentCharacterCalled = false
    var presentErrorCalled = false

    func presentCharacter(response: CharacterDetails.Fetch.Response) {
        self.presentCharacterCalled = true
        self.expectation?.fulfill()
    }
    
    func presentError(response: CharacterDetails.Error.Response) {
        self.presentErrorCalled = true
        self.expectation?.fulfill()
    }
    func presentShare(response: CharacterDetails.Share.Response) {}
}

