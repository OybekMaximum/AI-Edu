//
//  SettingsController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import UIKit

class SettingsController: BaseViewController {
    private let viewModel: SettingsViewModelProtocol

    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initialize() {
        super.initialize()


    }

    override func setupAppearance() {
        view.backgroundColor = .green
    }

    override func addSubviews() {

    }

    override func setConstraints() {

    }
}
