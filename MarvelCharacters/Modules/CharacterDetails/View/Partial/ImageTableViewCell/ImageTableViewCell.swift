//
//  ImageTableViewCell.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//

import UIKit
import SDWebImage

protocol ImageTableViewCellRenderData {
    var characterImageUrl: URL? { get }
}

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
    
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
    }
    
    public func render(viewModel: ImageTableViewCellRenderData) {
        self.pictureImageView.sd_setImage(
            with: viewModel.characterImageUrl,
            completed: nil
        )
    }
}
