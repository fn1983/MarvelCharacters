//
//  CharacterTableViewCell.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//

import UIKit
import Kingfisher

protocol CharacterTableViewCellRenderData {
    var characterImageUrl: URL? { get }
    var title: String { get }
    var caption: String { get }
}

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.setup()
    }
    
    private func setup() {
        self.selectionStyle = .none
        self.mainImageView.superview?.cornerRadius = 18
        self.titleLabel.font = .preferredFont(forTextStyle: .title1)
        self.captionLabel.font = .preferredFont(forTextStyle: .caption1)
    }
    
    public func render(viewModel: CharacterTableViewCellRenderData) {
        self.mainImageView.kf.setImage(with: viewModel.characterImageUrl)
        self.titleLabel.text = viewModel.title
        self.captionLabel.text = viewModel.caption
    }
}
