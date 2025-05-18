//
//  SettingsController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import UIKit

class SettingsController: BaseViewController {
    private let viewModel: SettingsViewModelProtocol

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private let profileCardView: ProfileCardView = {
        let profileCardView = ProfileCardView()
        profileCardView.translatesAutoresizingMaskIntoConstraints = false
        return profileCardView
    }()

    private let statisticsCardView: StatisticsCardView = {
        let view = StatisticsCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let achievementsCardView: AchievementsCardView = {
        let view = AchievementsCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func initialize() {
        super.initialize()

        // Configure the ProfileCardView with sample data
        profileCardView.configure(with: .iconBook, loginText: BuildConfiguration.shared.userName ?? "UNKNOWN USER")


        profileCardView.onLogoutTapped = { [weak self] in
            self?.viewModel.logout()
        }
    }

    override func setupAppearance() {
        super.setupAppearance()
        let strr = "Profile"

        navigationItem.title = strr
    }

    override func addSubviews() {
        view.addSubview(scrollView)

        scrollView.addSubview(contentView)
        contentView.addSubview(profileCardView)
        contentView.addSubview(statisticsCardView)
        contentView.addSubview(achievementsCardView)
    }

    override func setConstraints() {
        // ScrollView constraints
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // ContentView constraints
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1000),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // Ensures contentView fills the scrollView width
        ])

        // ProfileCardView constraints
        NSLayoutConstraint.activate([
            profileCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            profileCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            profileCardView.heightAnchor.constraint(equalToConstant: 160),

            statisticsCardView.topAnchor.constraint(equalTo: profileCardView.bottomAnchor, constant: 10),
            statisticsCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statisticsCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            achievementsCardView.topAnchor.constraint(equalTo: statisticsCardView.bottomAnchor, constant: 10),
            achievementsCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            achievementsCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

        ])
    }
}
