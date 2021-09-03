//
//  CharactersListPresenterTests.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 2/9/21.
//  Copyright (c) 2021. All rights reserved.
//

@testable import MarvelCharacters
import XCTest

class CharactersListPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharactersListPresenter!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        self.setupCharactersListPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupCharactersListPresenter() {
        self.sut = CharactersListPresenter()
    }

    // MARK: Tests
    func testPresentProducts() {
        // Given
        let spy = MockCharactersListDisplay()
        self.sut.viewController = spy
        spy.expectation = self.expectation(description: "waitPresentCharacters")

        // When
        self.sut.presentCharacters(
            response: .init(characters: [
                .init(
                    id: 87478,
                    name: "Lorem ipsum dolor sit amet",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris semper imperdiet lorem, eleifend rhoncus nibh scelerisque at. Pellentesque sollicitudin tortor eget porttitor rhoncus. Vivamus laoreet orci suscipit accumsan elementum. Vestibulum maximus nunc a odio tincidunt mattis.",
                    thumbnail: "http://google.com",
                    urls: []
                )
            ])
        )
        self.waitForExpectations(timeout: 60, handler: nil)

        // Then
        XCTAssertTrue(spy.displayCharactersCalled, "\(#function) should ask the view controller to display the result")
    }
    
    func testPresentError() {
        // Given
        let spy = MockCharactersListDisplay()
        self.sut.viewController = spy
        spy.expectation = self.expectation(description: "waitPresentCharacters")

        // When
        self.sut.presentError(
            response: .init(error: MarvelCharactersError.General.badPayload)
        )
        self.waitForExpectations(timeout: 60, handler: nil)

        // Then
        XCTAssertTrue(spy.displayError, "\(#function) should ask the view controller to display the result")
    }
}

private final class MockCharactersListDisplay: CharactersListDisplayLogic {
    var displayCharactersCalled = false
    var displayError = false
    var expectation: XCTestExpectation?

    func displayCharacters(viewModel: CharactersList.Fetch.ViewModel) {
        self.displayCharactersCalled = true
        self.expectation?.fulfill()
    }
    
    func displayError(viewModel: CharactersList.Error.ViewModel) {
        self.displayError = true
        self.expectation?.fulfill()
    }
}
