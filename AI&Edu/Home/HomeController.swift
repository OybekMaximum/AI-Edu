//
//  HomeController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import UIKit

class HomeController: BaseViewController {
    private let viewModel: HomeViewModelProtocol

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initialize() {
        super.initialize()

        view.backgroundColor = .blue
    }

    override func addSubviews() {
        super.addSubviews()

    }

    override func setConstraints() {
        super.setConstraints()

    }
}

