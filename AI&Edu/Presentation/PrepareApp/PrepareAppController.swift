//
//  PrepareAppController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 11/04/25.
//

import UIKit
import Combine

final class PrepareAppController: BaseViewController {
    private let loaderView: UIActivityIndicatorView = {
        let loaderView = UIActivityIndicatorView()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.style = .large
        loaderView.color = .white
        loaderView.isUserInteractionEnabled = false
        return loaderView
    }()

    private lazy var retryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.numberOfLines = 2
        button.setTitle("Network connection error, try again!", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        return button
    }()

    private let viewModel: PrepareAppViewModelProtocol
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: PrepareAppViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initialize() {
        super.initialize()

        addSubviews()
        setConstraints()
        setBindings()
        startLoading()

        Task { @MainActor in
            await viewModel.prepare()
        }
    }

    override func addSubviews() {
        view.addSubview(loaderView)
        view.addSubview(retryButton)
    }

    override func setConstraints() {
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderView.widthAnchor.constraint(equalToConstant: 100),
            loaderView.heightAnchor.constraint(equalTo: loaderView.widthAnchor),

            retryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            retryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            retryButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100),
            retryButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    private func setBindings() {
        viewModel.isNetworkAvailable
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.stopLoading()
            })
            .store(in: &cancellables)

        viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (isLoading) in
                isLoading ? self?.startLoading() : self?.stopLoading()
            })
            .store(in: &cancellables)
    }

    private func startLoading() {
        loaderView.isHidden = false
        retryButton.isHidden = true
        loaderView.startAnimating()
    }

    private func stopLoading() {
        loaderView.isHidden = true
        retryButton.isHidden = false
        loaderView.stopAnimating()
    }

    @objc
    private func tryAgainButtonTapped() {
        viewModel.checkInternetConnection()
    }
}
