//
//  DescriptionTableViewCell.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//

import UIKit

protocol DescriptionTableViewCellRenderData {
    var description: String { get }
}

class DescriptionTableViewCell: UITableViewCell {
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.descriptionLabel)
        self.descriptionLabel.layoutAttachAll(
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
        self.descriptionLabel.text?.removeAll()
    }

    public func render(viewModel: DescriptionTableViewCellRenderData) {
        self.descriptionLabel.text = viewModel.description
        if self.descriptionLabel.text?.isEmpty ?? true {
            self.descriptionLabel.text = "No description available"
        }
    }
}
