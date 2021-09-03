//
//  CharacterDetailsInteractor.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//  Copyright (c) 2021. All rights reserved.
//

protocol CharacterDetailsBusinessLogic {
    func fetchCharacter(request: CharacterDetails.Fetch.Request)
    func selectedShare()
    func selectedOpenLink(index: Int)
    func setViewController(_ viewController: CharacterDetailsDisplayLogic)
}

class CharacterDetailsInteractor: CharacterDetailsBusinessLogic {
    // MARK: - Dependencies
    private var id: Int
    private var presenter: CharacterDetailsPresentationLogic
    private var router: CharacterDetailsRouterLogic
    private var repository: CharactersRepositoryLogic

    // MARK: - Data Storage
    private var character: Character?

    init(
        id: Int,
        presenter: CharacterDetailsPresentationLogic,
        router: CharacterDetailsRouterLogic,
        repository: CharactersRepositoryLogic
    ) {
        self.id = id
        self.presenter = presenter
        self.router = router
        self.repository = repository
    }

    convenience init(
        withId id: Int,
        router: CharacterDetailsRouterLogic
    ) {
        self.init(
            id: id,
            presenter: CharacterDetailsPresenter(),
            router: router,
            repository: CharactersRepository()
        )
    }

    func fetchCharacter(request: CharacterDetails.Fetch.Request) {
        self.repository.fetchCharacter(withId: self.id) { result in
            do {
                let character = try result.get()
                self.character = character
                self.presenter.presentCharacter(
                    response: .init(character: character)
                )
            } catch {
                self.presenter.presentError(
                    response: .init(error: error)
                )
            }
        }
    }

    func selectedShare() {
        guard let character = self.character else { return }
        self.presenter.presentShare(response: .init(character: character))
    }

    func selectedOpenLink(index: Int) {
        guard let urls = self.character?.urls else { return }
        self.router.route(.toWebsite(url: urls[index].url))
    }

    func setViewController(_ viewController: CharacterDetailsDisplayLogic) {
        self.presenter.viewController = viewController
    }
}
