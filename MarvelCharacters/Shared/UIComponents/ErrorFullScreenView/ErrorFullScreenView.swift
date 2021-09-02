//
//  ErrorFullScreenView.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//

import UIKit

protocol ErrorFullScreenViewDelegate: AnyObject {
    func errorDidSelectRetryAction()
}

protocol ErrorFullScreenViewRenderData {
    var status: ErrorFullScreenView.Status { get }
}

class ErrorFullScreenView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var primaryButton: UIButton!

    public weak var delegate: ErrorFullScreenViewDelegate?

    convenience init() {
        self.init(frame: .zero)
    }

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

    func setupView() {
        self.titleLabel.font = .preferredFont(forTextStyle: .title1)
        self.captionLabel.font = .preferredFont(forTextStyle: .caption1)
        self.primaryButton.backgroundColor = .init(named: "buttons")
        self.primaryButton.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        self.primaryButton.cornerRadius = 2
        self.primaryButton.setTitleColor(.white, for: .normal)
    }

    func show(
        over viewController: UIViewController & ErrorFullScreenViewDelegate,
        viewModel: ErrorFullScreenViewRenderData
    ) {
        self.hide()
        guard self.superview == nil else { return }

        self.delegate = viewController
        self.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(self)
        self.layoutAttachAll()
        viewController.view.bringSubviewToFront(self)
        
        self.titleLabel.text = viewModel.status.title
        self.captionLabel.text = viewModel.status.caption
        self.primaryButton.setTitle("Retry", for: .normal)
        self.primaryButton.isHidden = self.primaryButton.title(for: .normal) == nil
        self.imageView.image = nil
        if let name = viewModel.status.image {
            self.imageView.image = UIImage(named: name)
        }
    }

    func hide() {
        self.removeFromSuperview()
    }

    @IBAction func primary(_ sender: Any) {
        self.delegate?.errorDidSelectRetryAction()
    }
}
