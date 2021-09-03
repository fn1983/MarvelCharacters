//
//  CharacterDetailsRouter.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//  Copyright (c) 2021. All rights reserved.
//

import UIKit

protocol CharacterDetailsRouterLogic {
    func route(_ destination: CharacterDetails.Routing)
}

class CharacterDetailsRouter: NSObject {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    private func routeToWebsite(withUrl strUrl: String) {
        guard let url = URL(string: strUrl) else { return }
        UIApplication.shared.open(url)
    }
}

extension CharacterDetailsRouter: CharacterDetailsRouterLogic {
    func route(_ destination: CharacterDetails.Routing) {
        switch destination {
        case .toWebsite(url: let url):
            self.routeToWebsite(withUrl: url)
        }
    }
}
