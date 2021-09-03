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
    func presentError(response: CharactersList.Error.Response)
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

    func presentError(response: CharactersList.Error.Response) {
        let viewModel: CharactersList.Error.ViewModel
        switch response.error {
        case MarvelCharactersError.DataTransferError.networkFailure(let error) where error == .notConnected:
            viewModel = .init(status: .networkError)
        case MarvelCharactersError.DataTransferError.networkFailure(let error) where error == .error(statusCode: 401, data: nil):
            viewModel = .init(status: .missingCredentials)
        default:
            viewModel = .init(status: .generalError)
        }
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayError(viewModel: viewModel)
        }
    }
}
