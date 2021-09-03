//
//  CharacterDetailsModels.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//  Copyright (c) 2021. All rights reserved.
//

import Foundation

enum CharacterDetails {
    typealias Section = Fetch.ViewModel.Section
    
    enum Fetch {}
    enum Error {}
    enum Share {}
    
    enum Routing {
        case toWebsite(url: String)
    }
}

extension CharacterDetails.Fetch {
    struct Request {}
    struct Response {
        let character: Character
    }
    struct ViewModel {
        enum Section {
            case image(data: ImageData)
            case title(data: TitleData)
            case description(data: DescriptionData)
            case actions
            case url(data: UrlData)
        }
        let sections: [Section]
    }
}

extension CharacterDetails.Fetch.ViewModel {
    struct ImageData: ImageTableViewCellRenderData {
        let characterImageUrl: URL?
    }
    struct TitleData: TitleTableViewCellRenderData {
        let title: String
    }
    struct DescriptionData: DescriptionTableViewCellRenderData {
        let description: String
    }
    struct UrlData {
        let index: Int
        let title: String
    }
}

extension CharacterDetails.Error {
    struct Response {
        let error: Error
    }
    struct ViewModel: ErrorFullScreenViewRenderData {
        let status: ErrorFullScreenView.Status
    }
}

extension CharacterDetails.Share {
    struct Response {
        let character: Character
    }
    struct ViewModel: CharacterViewRenderData {
        var characterImageUrl: URL?
        var title: String
        var caption: String
    }
}
