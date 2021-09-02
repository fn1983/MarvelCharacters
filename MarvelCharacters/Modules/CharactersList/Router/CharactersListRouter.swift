//
//  CharactersListRouter.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//  Copyright (c) 2021. All rights reserved.
//

import UIKit

protocol CharactersListRouterLogic {
    func route(_ destination: CharactersList.Routing)
}

class CharactersListRouter: NSObject {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func routeToDetails(withId id: Int) {
        let router = CharacterDetailsRouter(
            navigationController: self.navigationController
        )
        let interactor = CharacterDetailsInteractor(withId: id, router: router)
        let detailsVC = CharacterDetailsViewController(interactor: interactor)
        self.navigationController.present(detailsVC, animated: true, completion: nil)
    }
}

extension CharactersListRouter: CharactersListRouterLogic {
    func route(_ destination: CharactersList.Routing) {
        switch destination {
        case .toDetails(withId: let id):
            self.routeToDetails(withId: id)
        }
    }
}
