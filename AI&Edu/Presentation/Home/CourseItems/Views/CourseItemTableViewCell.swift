//
//  CourseItemTableViewCell.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 22/04/25.
//

import UIKit

final class CourseItemTableViewCell: BaseTableViewCell {
    private let containerView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .iconBook
        imageView.layer.cornerRadius = 23
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let completedBadge: UILabel = {
        let label = UILabel()
        let strr = "Completed"
        label.text = strr
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.8)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.textAlignment = .center
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.white
        imageView.scalesLargeContentImage = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func initialize() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        addSubviews()
        setConstraints()
    }

    override func addSubviews() {
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)

        containerView.contentView.addSubview(iconView)
        containerView.contentView.addSubview(labelsStackView)
        containerView.contentView.addSubview(completedBadge)
        containerView.contentView.addSubview(chevronImageView)

        contentView.addSubview(containerView)
    }

    override func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            iconView.leadingAnchor.constraint(equalTo: containerView.contentView.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: containerView.contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 46),
            iconView.heightAnchor.constraint(equalToConstant: 46),

            labelsStackView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            labelsStackView.centerYAnchor.constraint(equalTo: containerView.contentView.centerYAnchor),
            labelsStackView.trailingAnchor.constraint(lessThanOrEqualTo: completedBadge.leadingAnchor, constant: -8),

            completedBadge.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            completedBadge.heightAnchor.constraint(equalToConstant: 20),
            completedBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 80),
            completedBadge.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -8),

            chevronImageView.centerYAnchor.constraint(equalTo: containerView.contentView.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: containerView.contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with course: CourseItemModel) {
        titleLabel.text = course.title.isEmpty ? "Title is empty" : course.title
        subtitleLabel.text = course.description.isEmpty ? "Subtitle is empty" : course.description
        completedBadge.isHidden = !(course.isCompleted ?? false)
    }
}
