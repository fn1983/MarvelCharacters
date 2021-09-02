//
//  LoadingFullScreenView.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//

import UIKit
import Lottie

class LoadingFullScreenView: UIView {
    private var backgroundView: UIView!
    private var animationView: AnimationView!
    private var mustShowView: Bool = false
    private var hideCompletion: (() -> Void)?
    private var canHideView: Bool = true

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }

    private func setupView() {
        self.backgroundColor = .systemBackground

        self.backgroundView = UIView()
        self.backgroundView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.backgroundView)
        self.backgroundView.layoutAttachAll()

        let animationContainerView = UIView()
        animationContainerView.backgroundColor = .clear
        animationContainerView.addSizeConstraint(size: .init(width: 160, height: 160))

        let animationView: AnimationView = .init(name: "loader")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationContainerView.addSubview(animationView)
        animationView.layoutAttachAll()
        self.animationView = animationView

        let stackView = UIStackView(arrangedSubviews: {
            let label = UILabel()
            label.font = .preferredFont(forTextStyle: .subheadline)
            label.text = "Loading..."
            return [animationContainerView, label]
        }())
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 8

        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    func add(to container: UIView) {
        guard self.canHideView else { return }
        self.mustShowView = true
        DispatchQueue.main.asyncAfter(
            deadline: .now() + Constants.Loading.delay
        ) { [weak self] in
            guard let strongSelf = self else { return }
            guard strongSelf.superview == nil else { return }
            guard strongSelf.mustShowView else { return }

            strongSelf.frame = container.bounds
            container.addSubview(strongSelf)
            strongSelf.layoutAttachAll()
            container.bringSubviewToFront(strongSelf)

            strongSelf.animationView.play()
            strongSelf.mustShowView = false
            strongSelf.canHideView = false
            DispatchQueue.main.asyncAfter(
                deadline: .now() + Constants.Loading.minDisplayTime
            ) { [weak self] in
                self?.canHideView = true
                if let completion = self?.hideCompletion {
                    self?.hide(completion: completion)
                }
            }
        }
    }

    func hide(completion: @escaping (() -> Void) = {}) {
        guard self.canHideView else {
            self.hideCompletion = completion
            return
        }
        self.mustShowView = false
        self.hideCompletion = nil
        self.animationView.stop()
        self.removeFromSuperview()
        completion()
    }
}

