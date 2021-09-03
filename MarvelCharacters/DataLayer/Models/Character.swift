//
//  Product.swift
//  MarvelCharacters
//
//  Created by PAUL SOTO on 31/8/21.
//

import Foundation

public struct Character {
    let id: Int
    let name: String
    let description: String
    let thumbnail: String?
    let urls: [Url]?
}

extension Character {
    enum UrlType: String, Codable {
        case detail
        case wiki
        case comiclink
        
        var title: String {
            switch self {
            case .detail: return "Details"
            case .wiki: return "Wiki"
            case .comiclink: return "Comic Link"
            }
        }
    }
    struct Url: Codable {
        let type: UrlType
        let url: String
    }
}

extension Character: Codable {
    enum CodingKeys: CodingKey {
        case id
        case name
        case description
        case thumbnail
        case urls
    }
    
    enum ThumbnailCodingKeys: CodingKey {
        case path
        case `extension`
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            id: try container.decode(Int.self, forKey: .id),
            name: try container.decode(String.self, forKey: .name),
            description: try container.decode(String.self, forKey: .description),
            thumbnail: try? {
                let thumbnailContainer = try container.nestedContainer(
                    keyedBy: ThumbnailCodingKeys.self,
                    forKey: .thumbnail
                )
                let path = try thumbnailContainer.decode(String.self, forKey: .path)
                let ext = try thumbnailContainer.decode(String.self, forKey: .extension)
                let url = "\(path).\(ext)"
                guard url.isValidURL else {
                    throw MarvelCharactersError.DataTransferError.parsing(
                        MarvelCharactersError.General.badUrl
                    )
                }
                return url
            }(),
            urls: {
                let urls = try? container.decode([Throwable<Url>].self, forKey: .urls)
                return urls?.compactMap({ try? $0.result.get() })
            }()
        )
    }
}

extension Character: Equatable {
    public static func ==(lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}
