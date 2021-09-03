//
//  CharacterView.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 3/9/21.
//

import UIKit
import Kingfisher

protocol CharacterViewRenderData {
    var characterImageUrl: URL? { get }
    var title: String { get }
    var caption: String { get }
}

class CharacterView: UIView {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.fromNib()
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.fromNib()
        self.setupView()
    }

    private func setupView() {
        self.mainImageView.superview?.cornerRadius = 18
        self.titleLabel.font = .preferredFont(forTextStyle: .title1)
        self.captionLabel.font = .preferredFont(forTextStyle: .caption1)
    }
    
    public func prepareForRehuse() {
        self.mainImageView.kf.cancelDownloadTask()
        self.mainImageView.image = nil
        self.titleLabel.text?.removeAll()
        self.captionLabel.text?.removeAll()
    }
    
    public func render(viewModel: CharacterViewRenderData) {
        self.mainImageView.kf.setImage(with: viewModel.characterImageUrl)
        self.titleLabel.text = viewModel.title
        self.captionLabel.text = viewModel.caption
    }
}
