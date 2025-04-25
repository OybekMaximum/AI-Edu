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
        imageView.layer.cornerRadius = 40  // Circular photo
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

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupConstraints()
    }

    // MARK: - Setup Methods
    override func setupSubviews() {
        super.setupSubviews() // Add the container view first
        containerView.addSubview(userPhotoImageView)
        containerView.addSubview(loginLabel)
    }

    override func setupConstraints() {
        super.setupConstraints() // Keep the existing constraints for the containerView

        // Set constraints for userPhotoImageView (Center in containerView)
        NSLayoutConstraint.activate([
            userPhotoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            userPhotoImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            userPhotoImageView.widthAnchor.constraint(equalToConstant: 80),
            userPhotoImageView.heightAnchor.constraint(equalToConstant: 80)
        ])

        // Set constraints for loginLabel (Below the user photo)
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: userPhotoImageView.bottomAnchor, constant: 8),
            loginLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Public Method to Set Data
    func configure(with image: UIImage?, loginText: String) {
        userPhotoImageView.image = image
        loginLabel.text = loginText
    }
}
