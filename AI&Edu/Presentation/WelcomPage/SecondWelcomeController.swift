//
//  SecondWelcomeController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 16/05/25.
//

import UIKit

class SecondWelcomeController: BaseViewController {
    weak var coordinatorDelegate: FirstWelcomeCoordinatorDelegate?

    private let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.student2
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover Your Career!"
        label.textColor = .purple
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Take a free test to find the career path that suits you."
        label.textColor = .purple
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start AI Test", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()

    override func setupAppearance() {
        super.setupAppearance()
        view.backgroundColor = .black
    }

    override func addSubviews() {
        view.addSubview(illustrationImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(startButton)
        view.addSubview(skipButton)
    }

    override func setConstraints() {
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            illustrationImageView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 32),
            illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            illustrationImageView.heightAnchor.constraint(equalToConstant: 340),
            illustrationImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),

            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            startButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 32),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 160),
            startButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    @objc
    func skipButtonTapped() {
        coordinatorDelegate?.showHome()
    }

    @objc
    func startButtonTapped() {
        coordinatorDelegate?.showWritingTest()
    }
}
