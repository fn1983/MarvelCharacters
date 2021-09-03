//
//  TitleTableViewCell.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//

import UIKit

protocol TitleTableViewCellRenderData {
    var title: String { get }
}

class TitleTableViewCell: UITableViewCell {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let vStack = UIStackView(arrangedSubviews: {
            let view = UIView()
            view.backgroundColor = UIColor(named: "buttons")
            view.addSizeHeightConstraint(height: 1)
            return [
                self.titleLabel,
                view
            ]
        }())
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.spacing = 2

        let hStack = UIStackView(arrangedSubviews: [vStack])
        hStack.axis = .horizontal
        hStack.alignment = .top
        hStack.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(hStack)
        hStack.layoutAttachAll(
            insets: .init(top: 8, left: 16, bottom: 8, right: 16)
        )
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.setup()
    }

    private func setup() {
        self.selectionStyle = .none
        self.titleLabel.text?.removeAll()
    }

    public func render(viewModel: TitleTableViewCellRenderData) {
        self.titleLabel.text = viewModel.title
    }
}
