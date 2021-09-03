//
//  CharacterDetailsViewController.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//  Copyright (c) 2021. All rights reserved.
//

import UIKit

protocol CharacterDetailsDisplayLogic: AnyObject {
    func displayCharacter(viewModel: CharacterDetails.Fetch.ViewModel)
    func displayShare(viewModel: CharacterDetails.Share.ViewModel)
    func displayError(viewModel: CharacterDetails.Error.ViewModel)
}

class CharacterDetailsViewController: UIViewController {
    private var interactor: CharacterDetailsBusinessLogic
    private var viewModel: CharacterDetails.Fetch.ViewModel?

    public lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.layoutAttachAll()
        return tableView
    }()
    private lazy var loading: LoadingFullScreenView = .init()
    private lazy var error: ErrorFullScreenView = .init()

    init(interactor: CharacterDetailsBusinessLogic) {
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
            withType: ImageTableViewCell.self
        )
        self.tableView.registerCellFromNib(
            withType: ActionsTableViewCell.self
        )
        self.tableView.registerCell(
            withType: TitleTableViewCell.self
        )
        self.tableView.registerCell(
            withType: DescriptionTableViewCell.self
        )
        self.tableView.registerCell(withType: UITableViewCell.self)
        self.tableView.separatorStyle = .none

        let largeConfig = UIImage.SymbolConfiguration(
            pointSize: 24,
            weight: .bold,
            scale: .large
        )
        let largeCloseImg = UIImage(systemName: "xmark.circle.fill", withConfiguration: largeConfig)
        let button = UIButton()
        button.tintColor = .black
        button.setImage(largeCloseImg, for: .normal)
        button.addTarget(self, action: #selector(self.close(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addSizeConstraint(size: .init(width: 24, height: 24))
        self.view.addSubview(button)
        button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        self.view.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 8).isActive = true

        self.fetchCharacter()
    }

    @objc func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    private func fetchCharacter() {
        self.loading.add(to: self.view)
        self.interactor.fetchCharacter(request: .init())
    }
}

extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = self.viewModel?.sections[indexPath.row] else {
            fatalError()
        }
        switch section {
        case .image(data: let viewModel):
            let cell: ImageTableViewCell! = tableView.dequeueCell(withType: ImageTableViewCell.self, for: indexPath)
            cell.render(viewModel: viewModel)
            return cell
        case .title(data: let viewModel):
            let cell: TitleTableViewCell! = tableView.dequeueCell(withType: TitleTableViewCell.self, for: indexPath)
            cell.render(viewModel: viewModel)
            return cell
        case .description(data: let viewModel):
            let cell: DescriptionTableViewCell! = tableView.dequeueCell(withType: DescriptionTableViewCell.self, for: indexPath)
            cell.render(viewModel: viewModel)
            return cell
        case .actions:
            let cell: ActionsTableViewCell! = tableView.dequeueCell(withType: ActionsTableViewCell.self, for: indexPath)
            cell.delegate = self
            return cell
        case .url(data: let viewModel):
            let cell: UITableViewCell! = tableView.dequeueCell(withType: UITableViewCell.self, for: indexPath)
            let smallConfig = UIImage.SymbolConfiguration(
                pointSize: 18,
                weight: .semibold,
                scale: .small
            )
            if let image = UIImage(systemName: "chevron.right", withConfiguration: smallConfig) {
                let accessory  = UIImageView(
                    frame: CGRect(
                        x: 0,
                        y: 0,
                        width: image.size.width,
                        height: image.size.height
                    )
                )
                accessory.image = image
                accessory.tintColor = .red
                cell.accessoryView = accessory
            }
            cell.textLabel?.text = viewModel.title
            cell.textLabel?.font = .boldSystemFont(ofSize: 16)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = self.viewModel?.sections[indexPath.row] else {
            return
        }
        guard case .url(let viewModel) = section else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        self.interactor.selectedOpenLink(index: viewModel.index)
    }
}

extension CharacterDetailsViewController: ActionsTableViewCellDelegate {
    func userDidSelectShare() {
        self.interactor.selectedShare()
    }
}

extension CharacterDetailsViewController: CharacterDetailsDisplayLogic {
    func displayShare(viewModel: CharacterDetails.Share.ViewModel) {
        let view = CharacterView()
        view.isOpaque = false
        view.render(viewModel: viewModel)
        view.frame.size = view.systemLayoutSizeFitting(
            .init(width: 364, height: 364),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .required
        )
        view.setNeedsLayout()
        view.layoutIfNeeded()
        guard let sharingView = view.asImage() else { return }
        let activityViewController = UIActivityViewController(
            activityItems: [sharingView],
            applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    func displayCharacter(viewModel: CharacterDetails.Fetch.ViewModel) {
        self.viewModel = viewModel
        self.tableView.reloadData()
        self.error.hide()
        self.loading.hide()
    }

    func displayError(viewModel: CharacterDetails.Error.ViewModel) {
        self.loading.hide {
            self.error.show(over: self, viewModel: viewModel)
        }
    }
}

extension CharacterDetailsViewController: ErrorFullScreenViewDelegate {
    func errorDidSelectRetryAction() {
        self.fetchCharacter()
    }
}
