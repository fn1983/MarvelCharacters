//
//  APIEndpoints+Characters.swift
//  MarvelCharacters
//
//  Created by PAUL SOTO on 30/6/21.
//

import Foundation

extension APIEndpoints {
    static func getCharacters(
        offSet: Int,
        pageLimit: Int
    ) -> Endpoint<FetchCharactersDTO.Result> {
        .init(
            path: "characters",
            method: .get,
            queryParameters: [
                "offset": offSet,
                "limit": pageLimit
            ]
        )
    }
    
    static func getCharacter(
        withId id: Int
    ) -> Endpoint<FetchCharactersDTO.Result> {
        .init(
            path: "characters/\(id)",
            method: .get
        )
    }
}
