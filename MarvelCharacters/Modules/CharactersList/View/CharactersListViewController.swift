//
//  CharactersListViewController.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//  Copyright (c) 2021. All rights reserved.
//

import UIKit
import SDWebImage

protocol CharactersListDisplayLogic: AnyObject {
    func displayCharacters(viewModel: CharactersList.Fetch.ViewModel)
}

class CharactersListViewController: UIViewController {
    public lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        self.view.addSubview(tableView)
        tableView.layoutAttachAll()
        return tableView
    }()
    
    private var interactor: CharactersListBusinessLogic
    private var viewModel: CharactersList.Fetch.ViewModel?

    init(interactor: CharactersListBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
        interactor.setViewController(self)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset.bottom = 16
        self.tableView.registerCellFromNib(
            withType: CharacterTableViewCell.self
        )
        self.tableView.separatorStyle = .none
        self.interactor.fetchCharacters(request: .init())
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.characters.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterTableViewCell! = tableView.dequeueCell(
            withType: CharacterTableViewCell.self,
            for: indexPath
        )
        if let character = self.viewModel?.characters[indexPath.row] {
            cell.render(viewModel: character)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row + 3 == self.viewModel?.characters.count else {
            return
        }
        self.interactor.fetchCharacters(request: .init(loadMore: true))
    }
}

extension CharactersListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urls = self.viewModel?.characters.compactMap({ $0.characterImageUrl })
        SDWebImagePrefetcher.shared.prefetchURLs(urls)
    }
}

extension CharactersListViewController: CharactersListDisplayLogic {
    func displayCharacters(viewModel: CharactersList.Fetch.ViewModel) {
        self.viewModel = viewModel
        self.tableView.reloadData()
    }
}
