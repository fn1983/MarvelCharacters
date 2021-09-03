//
//  SceneDelegate.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window

        guard ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil else {
            return
        }

        let productsNavVc = UINavigationController()
        let router = CharactersListRouter(navigationController: productsNavVc)
        productsNavVc.setViewControllers([
            CharactersListViewController(
                interactor: CharactersListInteractor(router: router)
            )
        ], animated: false)

        window.rootViewController = productsNavVc
        window.makeKeyAndVisible()
    }
}
