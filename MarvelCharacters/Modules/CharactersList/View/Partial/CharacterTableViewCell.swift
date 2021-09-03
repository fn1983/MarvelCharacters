//
//  CharacterTableViewCell.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 31/8/21.
//

import UIKit

protocol CharacterTableViewCellRenderData: CharacterViewRenderData {}

class CharacterTableViewCell: UITableViewCell {
    @IBOutlet weak var characterView: CharacterView!
    
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
        self.characterView.prepareForRehuse()
    }
    
    public func render(viewModel: CharacterTableViewCellRenderData) {
        self.characterView.render(viewModel: viewModel)
    }
}
