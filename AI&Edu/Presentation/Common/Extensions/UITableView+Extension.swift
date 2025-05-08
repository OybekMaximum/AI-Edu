//
//  UITableView+Extension.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 17/04/25.
//

import UIKit

extension UITableView {
    func register<Cell>(_ cellClass: Cell.Type) where Cell: UITableViewCell {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }

    func register<View>(_ viewClass: View.Type) where View: UITableViewHeaderFooterView {
        register(viewClass, forHeaderFooterViewReuseIdentifier: String(describing: viewClass))
    }

    func dequeueReusableCell<Cell>(for indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
        dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
    }

    func dequeueReusableHeaderFooterView<View>() -> View? where View: UITableViewHeaderFooterView {
        dequeueReusableHeaderFooterView(withIdentifier: String(describing: View.self)) as? View
    }
}
