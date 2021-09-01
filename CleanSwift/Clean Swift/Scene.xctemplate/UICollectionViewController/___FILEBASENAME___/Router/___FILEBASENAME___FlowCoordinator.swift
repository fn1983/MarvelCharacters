//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

@objc protocol ___VARIABLE_sceneName___RouterLogic {
    //func presentSomeScreen()
    //func presentOtherScreen(args: SomeArguments)
}

class ___VARIABLE_sceneName___Router: NSObject {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: Routing
    //func presentSomeScreen() {
    //    let nextViewController = UIViewController()
    //    navigationController.push(nextViewController)
    //}

    //func presentOtherScreen(args: SomeArguments) {
    //      let nextViewController = UIViewController(withArgs: args)
    //      navigationController.rootViewController.present(nextViewController, animated: true)
    //}
}

extension ___VARIABLE_sceneName___Router: ___VARIABLE_sceneName___RouterLogic {

}