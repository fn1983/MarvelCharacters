//
//  APIEndpoints+ProductList.swift
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
        return .init(
            path: "characters",
            method: .get,
            queryParameters: [
                "offset": offSet,
                "limit": pageLimit
            ]
        )
    }
}
