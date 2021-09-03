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
    private var queue: DispatchQueue

    // Exposing convenience init for the clients
    public convenience init() {
        self.init(
            api: CharactersApiDataSource()
        )
    }

    internal init(
        api: CharactersDataSource
    ) {
        self.api = api
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
