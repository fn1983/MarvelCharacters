//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ___VARIABLE_sceneName___DisplayLogic: class {
    func displaySomething(viewModel: ___VARIABLE_sceneName___.Something.ViewModel)
}

class ___VARIABLE_sceneName___ViewController: UIViewController, ___VARIABLE_sceneName___DisplayLogic {
    var interactor: ___VARIABLE_sceneName___BusinessLogic

    //@IBOutlet weak var nameTextField: UITextField!

    init(interactor: ___VARIABLE_sceneName___BusinessLogic) {
        self.interactor = interactor
        super.init(nibName: "___VARIABLE_sceneName___ViewController", bundle: nil)
        interactor.setViewController(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.doSomething()
    }

    func doSomething() {
        let request = ___VARIABLE_sceneName___.Something.Request()
        self.interactor.doSomething(request: request)
    }

    func displaySomething(viewModel: ___VARIABLE_sceneName___.Something.ViewModel) {
        //self.nameTextField.text = viewModel.name
    }
}
