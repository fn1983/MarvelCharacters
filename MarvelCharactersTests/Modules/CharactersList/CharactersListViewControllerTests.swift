//
//  CharactersListViewControllerTests.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 2/9/21.
//  Copyright (c) 2021. All rights reserved.
//

@testable import MarvelCharacters
import XCTest

class CharactersListViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: CharactersListViewController!
    var window: UIWindow!
    
    private let spy = CharactersListBusinessLogicMock()

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        let scene = UIApplication.shared.connectedScenes.first
        if let sd: SceneDelegate = (scene?.delegate as? SceneDelegate) {
            self.window = sd.window
        }
        self.setupCharactersListViewController()
    }

    override func tearDown() {
        self.window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupCharactersListViewController() {
        self.sut = CharactersListViewController(interactor: self.spy)
        self.window.rootViewController = UINavigationController(
            rootViewController: self.sut
        )
        self.window.makeKeyAndVisible()
    }

    func loadView() {
        self.window.subviews.forEach({ $0.removeFromSuperview() })
        self.window.addSubview(self.sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Tests
    func testShouldFetchCharactersWhenViewIsLoaded() {
        // When
        self.loadView()
        // Then
        XCTAssertTrue(self.spy.fetchCharactersCalled, "\(#function) should ask the interactor to fetch the characters")
    }
    
    func testDisplayError() {
        // When
        self.loadView()

        self.sut.displayError(viewModel: .init(status: .generalError))
        
        // Then
        XCTAssertTrue(self.sut.view.subviews.contains(where: { $0 is ErrorFullScreenView }), "\(#function) should show the errorView")
    }

    func testDisplayCharacters() {
        // Given
        let viewModel = CharactersList.Fetch.ViewModel(
            characters: [
                .init(
                    characterImageUrl: .init(string: ""),
                    title: "Lorem ipsum dolor sit amet",
                    caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris semper imperdiet lorem, eleifend rhoncus nibh scelerisque at. Pellentesque sollicitudin tortor eget porttitor rhoncus. Vivamus laoreet orci suscipit accumsan elementum. Vestibulum maximus nunc a odio tincidunt mattis."
                )
            ]
        )

        // When
        self.loadView()

        self.sut.displayCharacters(viewModel: viewModel)

        // Then
        let predicate = NSPredicate(block: { any, _ in
            guard let table = any as? UITableView else {
                return false
            }
            return table.visibleCells.count > 0
        })

        let exp = expectation(
            for: predicate,
            evaluatedWith: self.sut.tableView,
            handler: nil
        )
        let result = XCTWaiter.wait(for: [exp], timeout: 60.0)
        if result == XCTWaiter.Result.completed {
            XCTAssertTrue(self.sut.tableView.visibleCells.count > 0, "\(#function) should show the table")
        } else {
            XCTFail("Delay interrupted")
        }
    }
}

private final class CharactersListBusinessLogicMock: CharactersListBusinessLogic {
    var fetchCharactersCalled = false
    
    func fetchCharacters(request: CharactersList.Fetch.Request) {
        self.fetchCharactersCalled = true
    }

    func selectedCharacter(withIndex index: Int) {}
    func setViewController(_ viewController: CharactersListDisplayLogic) {}
}
