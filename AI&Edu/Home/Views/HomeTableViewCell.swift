//
//  HomeTableViewCell.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 17/04/25.
//

import UIKit

final class CourseCardCell: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = .systemBackground
        return view
    }()

    private let courseImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let levelLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.styleAsTag(
            backgroundColor: .systemPink.withAlphaComponent(0.4),
            textColor: .commonWhite,
            cornerRadius: 12,
            font: Fonts.Inter.semiBold.font(size: 12))
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.Inter.bold.font(size: 18)
        label.textColor = Colors.contentPrimary.color
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.Inter.semiBold.font(size: 14)
        label.textColor = Colors.contentSecondary.color
        return label
    }()

    private let lessonsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.Inter.regular.font(size: 14)
        label.textColor = .borderBlack
        return label
    }()

    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let strr = "Start"
        button.setTitle(strr, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 16
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()

    let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(containerView)

        // Top image
        containerView.addSubview(courseImageView)

        // Text layout
        textStackView.addArrangedSubview(levelLabel)
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(subtitleLabel)

        bottomStackView.addArrangedSubview(lessonsLabel)
        bottomStackView.addArrangedSubview(startButton)

        containerView.addSubview(textStackView)
        containerView.addSubview(bottomStackView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

            courseImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            courseImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            courseImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            courseImageView.heightAnchor.constraint(equalToConstant: 160),

            levelLabel.heightAnchor.constraint(equalToConstant: 24),
//            levelLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),

            textStackView.topAnchor.constraint(equalTo: courseImageView.bottomAnchor, constant: 12),
            textStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            textStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            startButton.heightAnchor.constraint(equalToConstant: 36),
            startButton.widthAnchor.constraint(equalToConstant: 80),

            bottomStackView.topAnchor.constraint(equalTo: textStackView.bottomAnchor, constant: 12),
            bottomStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            bottomStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            bottomStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }

    func configure(with model: CourseModel) {
        if model.image == "" {
            courseImageView.image = .temp
        } else {
            //
        }

        if model.level == "" {
            levelLabel.isHidden = true
        } else {
            levelLabel.setTextWithPadding(model.title)
        }

        let titleStrr = "Conversational English"
        titleLabel.text = model.title == "" ? titleStrr : model.title

        let subtitleStrr = "Learn to communicate freely on everyday topics"
        subtitleLabel.text = model.description == "" ? subtitleStrr : model.description

        let strr = "lessons"
        lessonsLabel.text = "\(model.courseItems.count) \(strr)"
    }
}
