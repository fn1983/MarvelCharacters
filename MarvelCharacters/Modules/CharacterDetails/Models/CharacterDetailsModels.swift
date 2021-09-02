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
            case url
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
}

extension CharacterDetails.Error {
    struct Response {
        let error: Error
    }
    struct ViewModel: ErrorFullScreenViewRenderData {
        let status: ErrorFullScreenView.Status
    }
}
