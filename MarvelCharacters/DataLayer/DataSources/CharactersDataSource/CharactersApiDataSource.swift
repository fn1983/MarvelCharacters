//
//  CharactersApiDataSource.swift
//  MarvelCharacters
//
//  Created by PAUL SOTO on 30/6/21.
//

import Foundation

final class CharactersApiDataSource: CharactersDataSource {
    lazy var api: DataTransferService = {
        let apiDataNetwork = DefaultNetworkService(config: ApiDataNetworkConfig())
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

    func fetchCharacters(
        offSet: Int,
        pageLimit: Int,
        completion: @escaping (Result<CharactersResult, Error>) -> Void
    ) {
        let endpoint = APIEndpoints.getCharacters(
            offSet: offSet,
            pageLimit: pageLimit
        )
        self.api.request(with: endpoint) { (result: Result<FetchCharactersDTO.Result, MarvelCharactersError.DataTransferError>) in
            completion(Result {
                let data = try result.get()
                return (characters: data.characters, totalMatches: data.totalMatches)
            })
        }
    }
    
    func fetchCharacter(
        withId id: Int,
        completion: @escaping (Result<Character, Error>) -> Void
    ) {
        let endpoint = APIEndpoints.getCharacter(
            withId: id
        )
        self.api.request(with: endpoint) { (result: Result<FetchCharactersDTO.Result, MarvelCharactersError.DataTransferError>) in
            completion(Result {
                guard let character = try result.get().characters.first else {
                    throw MarvelCharactersError.DataTransferError.noResponse
                }
                return character
            })
        }
    }
}
