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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.layoutAttachAll(
            insets: .init(top: 16, left: 16, bottom: 16, right: 16)
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

