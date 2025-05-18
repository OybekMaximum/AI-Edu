//
//  ProfileCardView.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 25/04/25.
//

import UIKit

class ProfileCardView: BaseCardView {

    // MARK: - Properties
    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.init(systemName: "iphone.and.arrow.forward.outward"), for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()

    // Public logout action handler (can be assigned from outside)
    var onLogoutTapped: (() -> Void)?

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
        setupActions()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupConstraints()
        setupActions()
    }

    // MARK: - Setup Methods
    override func setupSubviews() {
        super.setupSubviews()
        containerView.addSubview(userPhotoImageView)
        containerView.addSubview(loginLabel)
        containerView.addSubview(logoutButton)
    }

    override func setupConstraints() {
        super.setupConstraints()

        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            logoutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),

            userPhotoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            userPhotoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 80),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 80),

            loginLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 8),
            loginLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

    private func setupActions() {
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }

    @objc private func logoutTapped() {
        onLogoutTapped?()
    }

    // MARK: - Public Method to Set Data
    func configure(with image: UIImage?, loginText: String) {
        userPhotoImageView.image = image
        loginLabel.text = loginText
    }
}
