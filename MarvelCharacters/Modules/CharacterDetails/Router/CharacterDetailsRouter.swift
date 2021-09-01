//
//  CharacterDetailsRouter.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//  Copyright (c) 2021. All rights reserved.
//

import UIKit

@objc protocol CharacterDetailsRouterLogic {}

class CharacterDetailsRouter: NSObject {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension CharacterDetailsRouter: CharacterDetailsRouterLogic {}
