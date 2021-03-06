//
//  CharactersListModels.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//  Copyright (c) 2021. All rights reserved.
//

import Foundation

enum CharactersList {
    enum Fetch {}
    enum Error {}

    enum Routing {
        case toDetails(withId: Int)
    }
}

extension CharactersList.Fetch {
    struct Request {
        var loadMore: Bool = false
    }
    struct Response {
        let characters: [Character]
    }
    struct ViewModel {
        let characters: [Character]
    }
}

extension CharactersList.Fetch.ViewModel {
    struct Character: CharacterTableViewCellRenderData {
        var characterImageUrl: URL?
        var title: String
        var caption: String
    }
}

extension CharactersList.Error {
    struct Response {
        let error: Error
    }
    struct ViewModel: ErrorFullScreenViewRenderData {
        let status: ErrorFullScreenView.Status
    }
}
