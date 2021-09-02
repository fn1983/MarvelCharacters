//
//  UITableView+Extensions.swift
//  MarvelCharacters
//
//  Created by Paul Soto on 1/9/21.
//

import UIKit

extension UITableView {
    func registerCell(withType type: UITableViewCell.Type) {
        self.register(type, forCellReuseIdentifier: type.identifier)
    }

    func registerCellFromNib(withType type: UITableViewCell.Type) {
        self.register(UINib(nibName: type.identifier, bundle: nil), forCellReuseIdentifier: type.identifier)
    }

    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type) -> T? {
        self.dequeueReusableCell(withIdentifier: type.identifier) as? T
    }

    func dequeueCell<T: UITableViewCell>(withType type: UITableViewCell.Type, for indexPath: IndexPath) -> T? {
        self.dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T
    }

    func registerHeaderFooter(withType type: UITableViewHeaderFooterView.Type) {
        self.register(type, forHeaderFooterViewReuseIdentifier: type.identifier)
    }

    func registerHeaderFooterFromNib(withType type: UITableViewHeaderFooterView.Type) {
        self.register(UINib(nibName: type.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: type.identifier)
    }

    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(withType type: UITableViewHeaderFooterView.Type) -> T? {
        self.dequeueReusableHeaderFooterView(withIdentifier: type.identifier) as? T
    }

    func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        self.tableHeaderView?.frame.size = header.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        )
        self.tableHeaderView?.setNeedsLayout()
        self.tableHeaderView?.layoutIfNeeded()
    }

    func setAndLayoutTableFooterView(footer: UIView) {
        self.tableFooterView = footer
        self.tableFooterView?.frame.size = footer.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        )
        self.tableFooterView?.setNeedsLayout()
        self.tableFooterView?.layoutIfNeeded()
    }
}
