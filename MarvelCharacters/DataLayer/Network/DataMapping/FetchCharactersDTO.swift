//
//  FetchCharactersDTO.swift
//  MarvelCharacters
//
//  Created by PAUL SOTO on 31/8/21.
//

import Foundation

enum FetchCharactersDTO {
    struct Request: Codable {}
    struct Result: Decodable {
        var characters: [Character]
        var totalMatches: Int
    }
}

extension FetchCharactersDTO.Result {
    enum CodingKeys: CodingKey {
        case data
    }

    enum DataCodingKeys: CodingKey {
        case offset
        case total
        case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let dataContainer = try container.nestedContainer(
            keyedBy: DataCodingKeys.self,
            forKey: .data
        )

        self.characters = try dataContainer.decode([Character].self, forKey: .results)
        self.totalMatches = try dataContainer.decode(Int.self, forKey: .total)
    }
}
