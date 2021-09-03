//
//  UIView+Extensions.swift
//  MarvelCharacters
//
//  Created by PAUL SOTO on 1/7/21.
//

import UIKit

extension UIView {
    // MARK: - Borders
    @objc
    enum Side: Int8 {
        case left, right, top, bottom
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], radius: newValue)
        }
    }

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let borderColor = self.layer.borderColor else {
                return .clear
            }
            return .init(cgColor: borderColor)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }

    @IBInspectable
    var shadowColor: UIColor {
        get {
            guard let shadowColor = self.layer.shadowColor else {
                return .clear
            }
            return .init(cgColor: shadowColor)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }

    @IBInspectable
    var shadowOpacity: Float {
        get {
            self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }

    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    func addBorder(toSide side: UIView.Side, withColor color: CGColor, andThickness thickness: CGFloat, leftOffset: CGFloat = 0) {
        let border = CALayer()
        border.backgroundColor = color
        switch side {
        case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .top: border.frame = CGRect(x: frame.minX + leftOffset, y: frame.minY, width: frame.width, height: thickness)
        case .bottom: border.frame = CGRect(x: frame.minX + leftOffset, y: frame.maxY - thickness, width: frame.width, height: thickness)
        }
        self.layer.addSublayer(border)
    }

    // MARK: - Creation
    @discardableResult
    func fromNib<T: UIView>(usingIpadLayout: Bool = false) -> T? {
        let nibName = String(describing: type(of: self)) + (usingIpadLayout && UIDevice.current.userInterfaceIdiom == .pad ? "~ipad" : "")

        let nib = UINib(
            nibName: nibName,
            bundle: Bundle(for: type(of: self))
        )

        guard let contentView = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Could not load view from nib file.")
        }

        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttachAll()
        return contentView
    }

    // MARK: - Attaching To Views
    /// Attaches all sides of the receiver to its parent view
    func layoutAttachAll(insets: UIEdgeInsets = .zero, toSafeArea: Bool = false) {
        let item = toSafeArea ? superview?.safeAreaLayoutGuide : superview
        self.layoutAttachTop(to: item, margin: insets.top)
        self.layoutAttachBottom(to: item, margin: insets.bottom)
        self.layoutAttachLeading(to: item, margin: insets.left)
        self.layoutAttachTrailing(to: item, margin: insets.right)
    }

    /**
    Attaches the top of the current view to the given view's top if it's a
    superview of the current view, or to it's bottom if it's not
    (assuming this is then a sibling view).
    if view is not provided, the current view's super view is used
    */
    @discardableResult
    func layoutAttachTop(to: Any? = nil, margin: CGFloat = 0.0) -> NSLayoutConstraint {
        let item: Any? = to ?? self.superview
        let isSuperview = ((item as? UIView) == self.superview) || false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .top,
            relatedBy: .equal,
            toItem: item,
            attribute: (!(item is UIView) || isSuperview) ? .top : .bottom,
            multiplier: 1.0,
            constant: margin
        )
        self.superview?.addConstraint(constraint)
        return constraint
    }

    /// attaches the bottom of the current view to the given view
    @discardableResult
    func layoutAttachBottom(to: Any? = nil, margin: CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let item: Any? = to ?? self.superview
        let isSuperview = ((item as? UIView) == self.superview) || false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: item,
            attribute: (!(item is UIView) || isSuperview) ? .bottom : .top,
            multiplier: 1.0,
            constant: -margin
        )
        if let priority = priority {
            constraint.priority = priority
        }
        self.superview?.addConstraint(constraint)
        return constraint
    }

    /// attaches the leading edge of the current view to the given view
    @discardableResult
    func layoutAttachLeading(to: Any? = nil, margin: CGFloat = 0.0) -> NSLayoutConstraint {
        let item: Any? = to ?? self.superview
        let isSuperview = ((item as? UIView) == self.superview) || false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .leading,
            relatedBy: .equal,
            toItem: item,
            attribute: (!(item is UIView) || isSuperview) ? .leading : .trailing,
            multiplier: 1.0,
            constant: margin
        )
        self.superview?.addConstraint(constraint)
        return constraint
    }

    /// attaches the trailing edge of the current view to the given view
    @discardableResult
    func layoutAttachTrailing(to: Any? = nil, margin: CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let item: Any? = to ?? self.superview
        let isSuperview = ((item as? UIView) == self.superview) || false
        let constraint = NSLayoutConstraint(
            item: self,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: item,
            attribute: (!(item is UIView) || isSuperview) ? .trailing : .leading,
            multiplier: 1.0,
            constant: -margin
        )
        if let priority = priority {
            constraint.priority = priority
        }
        self.superview?.addConstraint(constraint)
        return constraint
    }

    @discardableResult
    func addSizeConstraint(size: CGSize = .zero, priority: UILayoutPriority? = nil) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
        let heightConstraint = self.addSizeHeightConstraint(
            height: size.height,
            priority: priority
        )
        let widthConstraint = self.addSizeWidthConstraint(
            width: size.width,
            priority: priority
        )
        return (width: widthConstraint, height: heightConstraint)
    }

    @discardableResult
    func addSizeHeightConstraint(height: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let heightConstraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: height
        )
        if let priority = priority {
            heightConstraint.priority = priority
        }
        self.addConstraint(heightConstraint)
        return heightConstraint
    }

    @discardableResult
    func addSizeWidthConstraint(width: CGFloat, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {
        let widthConstraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: width
        )
        if let priority = priority {
            widthConstraint.priority = priority
        }
        self.addConstraint(widthConstraint)
        return widthConstraint
    }
    
    func asImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        guard let currentContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        currentContext.setFillColor(cyan: 0, magenta: 0, yellow: 0, black: 0, alpha: 1)
        self.layer.render(in: currentContext)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
