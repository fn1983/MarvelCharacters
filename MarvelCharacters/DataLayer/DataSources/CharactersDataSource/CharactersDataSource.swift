//
//  CharactersDataSource.swift
//  MarvelCharacters
//
//  Created by PAUL SOTO on 30/6/21.
//

import Foundation

public typealias CharactersResult = (characters: [Character], totalMatches: Int)

// Remote data sources protocol
protocol CharactersDataSource {
    func fetchCharacters(
        offSet: Int,
        pageLimit: Int,
        completion: @escaping (Result<CharactersResult, Error>) -> Void
    )
    func fetchCharacter(withId id: String, completion: @escaping (Result<Character, Error>) -> Void)
}

// Local data sources protocol
protocol CharactersCachedDataSource {}
