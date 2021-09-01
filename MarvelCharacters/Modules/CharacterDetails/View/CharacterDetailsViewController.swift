//
//  CharacterDetailsViewController.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//  Copyright (c) 2021. All rights reserved.
//

import UIKit

protocol CharacterDetailsDisplayLogic: AnyObject {
    func displaySomething(viewModel: CharacterDetails.Something.ViewModel)
}

class CharacterDetailsViewController: UIViewController, CharacterDetailsDisplayLogic {
    var interactor: CharacterDetailsBusinessLogic

    //@IBOutlet weak var nameTextField: UITextField!

    init(interactor: CharacterDetailsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: "CharacterDetailsViewController", bundle: nil)
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
        let request = CharacterDetails.Something.Request()
        self.interactor.doSomething(request: request)
    }

    func displaySomething(viewModel: CharacterDetails.Something.ViewModel) {
        //self.nameTextField.text = viewModel.name
    }
}
