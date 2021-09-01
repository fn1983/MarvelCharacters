//
//  CharacterDetailsPresenter.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//  Copyright (c) 2021. All rights reserved.
//

protocol CharacterDetailsPresentationLogic {
    var viewController: CharacterDetailsDisplayLogic? { get set }
    func presentSomething(response: CharacterDetails.Something.Response)
}

class CharacterDetailsPresenter: CharacterDetailsPresentationLogic {
    weak var viewController: CharacterDetailsDisplayLogic?

    func presentSomething(response: CharacterDetails.Something.Response) {
        let viewModel = CharacterDetails.Something.ViewModel()
        self.viewController?.displaySomething(viewModel: viewModel)
    }
}
