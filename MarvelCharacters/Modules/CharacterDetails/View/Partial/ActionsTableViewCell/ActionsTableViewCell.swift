//
//  ActionsTableViewCell.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 2/9/21.
//

import UIKit

protocol ActionsTableViewCellDelegate: AnyObject {
    func userDidSelectShare()
}

class ActionsTableViewCell: UITableViewCell {
    public weak var delegate: ActionsTableViewCellDelegate?
    
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
    
    @IBAction func shareAction(_ sender: Any) {
        self.delegate?.userDidSelectShare()
    }
}
