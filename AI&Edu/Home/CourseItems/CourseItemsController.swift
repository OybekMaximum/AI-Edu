//
//  CourseItemsController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 22/04/25.
//

import UIKit

class CourseItemsController: BaseViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 86
        tableView.contentInset.top = 8
        tableView.register(CourseItemTableViewCell.self)
        return tableView
    }()

    private let viewModel: CourseItemsViewModelProtocol

    init(viewModel: CourseItemsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setupAppearance() {
        super.setupAppearance()
        
        let strr = "Courses"

        navigationItem.title = strr
    }

    override func addSubviews() {
        view.addSubview(tableView)
    }

    override func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension CourseItemsController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.courseItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CourseItemTableViewCell()
        cell.configure(with: viewModel.courseItems[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

