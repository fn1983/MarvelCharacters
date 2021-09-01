//
//  CharactersListRouter.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//  Copyright (c) 2021. All rights reserved.
//

import UIKit

@objc protocol CharactersListRouterLogic {}

class CharactersListRouter: NSObject {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CharactersListRouter: CharactersListRouterLogic {}
