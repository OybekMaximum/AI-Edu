//
//  StatisticsView.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 25/04/25.
//

import UIKit

class StatisticsCardView: UIView {
    private let statsTitleLabel = UILabel()
    private let statsStackView = UIStackView()
    private let activityTitleLabel = UILabel()
    private let activityStackView = UIStackView()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupAppearance() {
        backgroundColor = .white
        layer.cornerRadius = 20
        clipsToBounds = true
    }

    private func setupSubviews() {
        // Stats stack
        statsStackView.axis = .horizontal
        statsStackView.distribution = .fillEqually
        statsStackView.spacing = 12
        statsStackView.translatesAutoresizingMaskIntoConstraints = false

        let streak = StatBoxView(icon: nil, value: "🔥 12", label: "Day streak", valueColor: .systemPink)
        let words = StatBoxView(icon: nil, value: "542", label: "Words learned", valueColor: .systemBlue)
        let accuracy = StatBoxView(icon: nil, value: "85%", label: "Accuracy", valueColor: .systemTeal)

        [streak, words, accuracy].forEach { statsStackView.addArrangedSubview($0) }

        // stats title
        statsTitleLabel.text = "Statistics"
        statsTitleLabel.font = .boldSystemFont(ofSize: 20)
        statsTitleLabel.textColor = .black
        statsTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Weekly activity
        activityTitleLabel.text = "Weekly activity"
        activityTitleLabel.font = .boldSystemFont(ofSize: 20)
        activityTitleLabel.textColor = .black
        activityTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        activityStackView.axis = .horizontal
        activityStackView.distribution = .fillEqually
        activityStackView.alignment = .bottom
        activityStackView.spacing = 2
        activityStackView.translatesAutoresizingMaskIntoConstraints = false

        let barHeights = [20, 40, 60, 80, 60, 70, 30]
        let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

        for i in 0..<7 {
            let bar = DayActivityBarView(height: CGFloat(barHeights[i]), label: days[i])
            activityStackView.addArrangedSubview(bar)
        }

        // Add all to view
        addSubview(statsTitleLabel)
        addSubview(statsStackView)
        addSubview(activityTitleLabel)
        addSubview(activityStackView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            statsTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            statsTitleLabel.leadingAnchor.constraint(equalTo: statsStackView.leadingAnchor),

            statsStackView.topAnchor.constraint(equalTo: statsTitleLabel.bottomAnchor, constant: 16),
            statsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            activityTitleLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 24),
            activityTitleLabel.leadingAnchor.constraint(equalTo: statsStackView.leadingAnchor),

            activityStackView.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 16),
            activityStackView.leadingAnchor.constraint(equalTo: statsStackView.leadingAnchor),
            activityStackView.trailingAnchor.constraint(equalTo: statsStackView.trailingAnchor),
            activityStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            activityStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

class StatBoxView: UIView {

    init(icon: String?, value: String, label: String, valueColor: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        layer.cornerRadius = 12

        let iconLabel = UILabel()
        iconLabel.text = icon
        iconLabel.font = .systemFont(ofSize: 16)
        iconLabel.translatesAutoresizingMaskIntoConstraints = false

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = valueColor
        valueLabel.font = .boldSystemFont(ofSize: 18)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false

        let descLabel = UILabel()
        descLabel.text = label
        descLabel.font = .systemFont(ofSize: 14)
        descLabel.textColor = .gray
        descLabel.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [iconLabel, valueLabel, descLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -8),
            stack.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 8),
            stack.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DayActivityBarView: UIView {

    init(height: CGFloat, label: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        let bar = UIView()
        bar.backgroundColor = UIColor.systemBlue
        bar.layer.cornerRadius = 6
        bar.translatesAutoresizingMaskIntoConstraints = false

        let dayLabel = UILabel()
        dayLabel.text = label
        dayLabel.font = .systemFont(ofSize: 12)
        dayLabel.textColor = .lightGray
        dayLabel.textAlignment = .center
        dayLabel.translatesAutoresizingMaskIntoConstraints = false

        let stack = UIStackView(arrangedSubviews: [bar, dayLabel])
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            bar.heightAnchor.constraint(equalToConstant: height),
            bar.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            bar.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
