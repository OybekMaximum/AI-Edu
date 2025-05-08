//
//  AchievementsCardView.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 25/04/25.
//

import UIKit

class AchievementsCardView: UIView {
    private let titleLabel = UILabel()
    private let statsStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAppearance() {
        backgroundColor = .white
        layer.cornerRadius = 20
        clipsToBounds = true
    }

    private func setupSubviews() {
        // Title
        titleLabel.text = "Achievements"
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        // Stats stack
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 12
        statsStackView.translatesAutoresizingMaskIntoConstraints = false

        let streak = StatBoxView(icon: nil, value: "🏆", label: "Intermediate", valueColor: .systemPink)
        let words = StatBoxView(icon: nil, value: "😎", label: "10 Days", valueColor: .systemBlue)
        let accuracy = StatBoxView(icon: nil, value: "📖", label: "500 Words", valueColor: .systemTeal)

        [streak, words, accuracy].forEach { statsStackView.addArrangedSubview($0) }
        addSubview(statsStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            statsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            statsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
}
