//
//  CharacterDetailsPresenter.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//  Copyright (c) 2021. All rights reserved.
//

import Foundation

protocol CharacterDetailsPresentationLogic {
    var viewController: CharacterDetailsDisplayLogic? { get set }
    func presentCharacter(response: CharacterDetails.Fetch.Response)
    func presentShare(response: CharacterDetails.Share.Response)
    func presentError(response: CharacterDetails.Error.Response)
}

class CharacterDetailsPresenter: CharacterDetailsPresentationLogic {
    weak var viewController: CharacterDetailsDisplayLogic?

    func presentCharacter(response: CharacterDetails.Fetch.Response) {
        var sections: [CharacterDetails.Section] = [
            .image(
                data: .init(characterImageUrl: {
                    guard let str = $0.thumbnail else {
                        return nil
                    }
                    return URL(string: str)
                }(response.character))
            ),
            .actions,
            .title(
                data: .init(title: response.character.name)
            ),
            .description(
                data: .init(description: response.character.description)
            )
        ]
        for (index, url) in (response.character.urls ?? []).enumerated() {
            sections.append(
                .url(data: .init(index: index, title: url.type.title))
            )
        }
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayCharacter(viewModel: .init(sections: sections))
        }
    }

    func presentShare(response: CharacterDetails.Share.Response) {
        let viewModel = CharacterDetails.Share.ViewModel(
            characterImageUrl: {
                guard let str = $0.thumbnail else {
                    return nil
                }
                return URL(string: str)
            }(response.character),
            title: response.character.name,
            caption: response.character.description
        )

        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayShare(viewModel: viewModel)
        }
    }

    func presentError(response: CharacterDetails.Error.Response) {
        let viewModel: CharacterDetails.Error.ViewModel
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
