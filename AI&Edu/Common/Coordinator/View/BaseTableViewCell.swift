//
//  BaseTableViewCell.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 22/04/25.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {
    public static var reuseIdentifier: String {
        String(describing: self)
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        initialize()
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func initialize() {
        
    }

    open func addSubviews() {
        fatalError("addSubviews() has not been implemented")
    }

    open func setConstraints() {
        fatalError("setConstraints() has not been implemented")
    }
}

