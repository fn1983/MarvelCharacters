//
//  CharactersListInteractor.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//  Copyright (c) 2021. All rights reserved.
//

protocol CharactersListBusinessLogic {
    func fetchCharacters(request: CharactersList.Fetch.Request)
    func selectedCharacter(withIndex index: Int)
    func setViewController(_ viewController: CharactersListDisplayLogic)
}

class CharactersListInteractor: CharactersListBusinessLogic {
    // MARK: - Dependencies
    private var presenter: CharactersListPresentationLogic
    private var router: CharactersListRouterLogic
    private var repository: CharactersRepositoryLogic

    // MARK: - Data Storage
    private var searchResults: [Character] = []
    private let pageLimit = 21
    private var offSet = 0
    private var lastSearchedText: String?
    private var lastSearchTotalMatches: Int = 0

    init(
        presenter: CharactersListPresentationLogic,
        router: CharactersListRouterLogic,
        repository: CharactersRepositoryLogic
    ) {
        self.presenter = presenter
        self.router = router
        self.repository = repository
    }

    convenience init(router: CharactersListRouterLogic) {
        self.init(
            presenter: CharactersListPresenter(),
            router: router,
            repository: CharactersRepository()
        )
    }

    func fetchCharacters(request: CharactersList.Fetch.Request) {
        if !request.loadMore {
            self.offSet = 0
            self.lastSearchTotalMatches = 0
            self.searchResults = .init()
            self.lastSearchedText = nil
        }
        self.repository.fetchCharacters(offSet: self.offSet, pageLimit: self.pageLimit) { result in
            do {
                let result = try result.get()
                self.lastSearchTotalMatches = result.totalMatches
                self.offSet += result.characters.count
                self.searchResults.append(contentsOf: result.characters)
                self.presenter.presentCharacters(
                    response: .init(characters: self.searchResults)
                )
            } catch {
                self.presenter.presentError(
                    response: .init(error: error)
                )
            }
        }
    }

    func selectedCharacter(withIndex index: Int) {
        guard (0..<self.searchResults.count).contains(index) else {
            return
        }
        self.router.route(
            .toDetails(withId: self.searchResults[index].id)
        )
    }

    func setViewController(_ viewController: CharactersListDisplayLogic) {
        self.presenter.viewController = viewController
    }
}
