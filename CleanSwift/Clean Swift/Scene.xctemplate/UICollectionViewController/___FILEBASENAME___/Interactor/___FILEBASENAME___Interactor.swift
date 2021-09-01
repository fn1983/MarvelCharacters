//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

protocol ___VARIABLE_sceneName___BusinessLogic {
    func doSomething(request: ___VARIABLE_sceneName___.Something.Request)

    func setViewController(_ viewController: ___VARIABLE_sceneName___DisplayLogic)
}

class ___VARIABLE_sceneName___Interactor: ___VARIABLE_sceneName___BusinessLogic {
    var presenter: ___VARIABLE_sceneName___PresentationLogic
    var router: ___VARIABLE_sceneName___RouterLogic
    //var name: String = ""

    init(presenter: ___VARIABLE_sceneName___PresentationLogic, router: ___VARIABLE_sceneName___RouterLogic) {
        self.presenter = presenter
        self.router = router
    }

    func doSomething(request: ___VARIABLE_sceneName___.Something.Request) {
        let response = ___VARIABLE_sceneName___.Something.Response()
        self.presenter.presentSomething(response: response)
    }

    func setViewController(_ viewController: ___VARIABLE_sceneName___DisplayLogic) {
        self.presenter.viewController = viewController
    }
}
