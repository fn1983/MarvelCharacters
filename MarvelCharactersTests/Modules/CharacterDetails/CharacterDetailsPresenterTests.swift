//
//  CharacterDetailsPresenterTests.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 2/9/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

@testable import MarvelCharacters
import XCTest

class CharacterDetailsPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharacterDetailsPresenter!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        self.setupCharacterDetailsPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupCharacterDetailsPresenter() {
        self.sut = CharacterDetailsPresenter()
    }

    // MARK: Tests
    func testPresentProducts() {
        // Given
        let spy = MockCharacterDetailsDisplay()
        self.sut.viewController = spy
        spy.expectation = self.expectation(description: "waitPresentCharacter")

        // When
        self.sut.presentCharacter(
            response: .init(character: .init(
                id: 87478,
                name: "Lorem ipsum dolor sit amet",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris semper imperdiet lorem, eleifend rhoncus nibh scelerisque at. Pellentesque sollicitudin tortor eget porttitor rhoncus. Vivamus laoreet orci suscipit accumsan elementum. Vestibulum maximus nunc a odio tincidunt mattis.",
                thumbnail: "http://google.com"
            ))
        )
        self.waitForExpectations(timeout: 60, handler: nil)

        // Then
        XCTAssertTrue(spy.displayCharacterCalled, "\(#function) should ask the view controller to display the result")
    }
    
    func testPresentError() {
        // Given
        let spy = MockCharacterDetailsDisplay()
        self.sut.viewController = spy
        spy.expectation = self.expectation(description: "waitPresentCharacter")

        // When
        self.sut.presentError(
            response: .init(error: MarvelCharactersError.General.badPayload)
        )
        self.waitForExpectations(timeout: 60, handler: nil)

        // Then
        XCTAssertTrue(spy.displayError, "\(#function) should ask the view controller to display the result")
    }
}

private final class MockCharacterDetailsDisplay: CharacterDetailsDisplayLogic {
    var displayCharacterCalled = false
    var displayError = false
    var expectation: XCTestExpectation?

    func displayCharacter(viewModel: CharacterDetails.Fetch.ViewModel) {
        self.displayCharacterCalled = true
        self.expectation?.fulfill()
    }
    
    func displayError(viewModel: CharacterDetails.Error.ViewModel) {
        self.displayError = true
        self.expectation?.fulfill()
    }
}
