//
//  CharacterDetailsInteractor.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//  Copyright (c) 2021. All rights reserved.
//

protocol CharacterDetailsBusinessLogic {
    func doSomething(request: CharacterDetails.Something.Request)

    func setViewController(_ viewController: CharacterDetailsDisplayLogic)
}

class CharacterDetailsInteractor: CharacterDetailsBusinessLogic {
    var presenter: CharacterDetailsPresentationLogic
    var router: CharacterDetailsRouterLogic
    //var name: String = ""

    init(presenter: CharacterDetailsPresentationLogic, router: CharacterDetailsRouterLogic) {
        self.presenter = presenter
        self.router = router
    }

    func doSomething(request: CharacterDetails.Something.Request) {
        let response = CharacterDetails.Something.Response()
        self.presenter.presentSomething(response: response)
    }

    func setViewController(_ viewController: CharacterDetailsDisplayLogic) {
        self.presenter.viewController = viewController
    }
}
