//
//  CharactersRepository.swift
//  MarvelCharacters
//
//  Created by PAUL SOTO on 31/8/21.
//

import Foundation

protocol CharactersRepositoryLogic {
    func fetchCharacters(
        offSet: Int,
        pageLimit: Int,
        completion: @escaping (Result<CharactersResult, Error>) -> Void
    )
    func fetchCharacter(
        withId id: Int,
        completion: @escaping (Result<Character, Error>) -> Void
    )
}

public class CharactersRepository: CharactersRepositoryLogic {
    // MARK: Remote Data Sources
    private var api: CharactersDataSource

    // MARK: Local Data Sources
    // private var charactersDS: CharactersCachedDataSource

    private var queue: DispatchQueue

    // Exposing convenience init for the clients
    public convenience init() {
        self.init(
            api: CharactersApiDataSource()
            //store: CharactersRealmDataSource()
        )
    }

    internal init(
        api: CharactersDataSource
        //store: CharactersCachedDataSource
    ) {
        self.api = api
        //self.charactersDS = store
        self.queue = DispatchQueue(
            label: "com.pj.CharactersRepository",
            qos: .userInitiated,
            autoreleaseFrequency: .workItem
        )
    }

    func fetchCharacters(
        offSet: Int,
        pageLimit: Int,
        completion: @escaping (Result<CharactersResult, Error>) -> Void
    ) {
        self.queue.async {
            self.api.fetchCharacters(
                offSet: offSet,
                pageLimit: pageLimit,
                completion: completion
            )
            /*
             Before call completion you could maybe use the store
             to save the data and apply some rules to return persisted
             data.
             */
        }
    }
    
    func fetchCharacter(
        withId id: Int,
        completion: @escaping (Result<Character, Error>) -> Void
    ) {
        self.queue.async {
            self.api.fetchCharacter(withId: id, completion: completion)
        }
    }
}
