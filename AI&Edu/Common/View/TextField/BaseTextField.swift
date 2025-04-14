//
//  BaseTextField.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import UIKit

class BaseTextField: UITextField {
    init() {
        super.init(frame: .zero)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize() {}

    func setupAppearance() {
        fatalError("setupAppearance() has not been implemented")
    }

    func addSubviews() {
        fatalError("addSubviews() has not been implemented")
    }

    func setConstraints() {
        fatalError("setConstraints() has not been implemented")
    }
}
