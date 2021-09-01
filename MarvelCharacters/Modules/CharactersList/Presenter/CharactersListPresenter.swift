//
//  CharactersListPresenter.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//  Copyright (c) 2021. All rights reserved.
//

import Foundation

protocol CharactersListPresentationLogic {
    var viewController: CharactersListDisplayLogic? { get set }
    func presentCharacters(response: CharactersList.Fetch.Response)
}

class CharactersListPresenter: CharactersListPresentationLogic {
    weak var viewController: CharactersListDisplayLogic?

    func presentCharacters(response: CharactersList.Fetch.Response) {
        let viewModel = CharactersList.Fetch.ViewModel(
            characters: response.characters.map({
                .init(
                    characterImageUrl: {
                        guard let str = $0.thumbnail else {
                            return nil
                        }
                        return URL(string: str)
                    }($0),
                    title: $0.name,
                    caption: $0.description
                )
            })
        )
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayCharacters(viewModel: viewModel)
        }
    }
}
