//
//  CourseItemsController.swift
//  AI&Edu
//
//  Created by Oybek To'laboyev on 22/04/25.
//

import UIKit
import Combine

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

    private lazy var footerView: UIButton = {
        let frame = CGRect(origin: .zero, size: .init(width: view.bounds.width, height: 72))
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let image = UIImage(systemName: "square.and.pencil", withConfiguration: config)
        let normalColor = UIColor.blue
        let highlightedColor = UIColor.blue.withAlphaComponent(0.6)

        let button = UIButton(frame: frame)
        button.setTitle("Take a writing exam", for: .normal)
        button.titleLabel?.font = Fonts.Inter.bold.font(size: 20)
        button.setTitleColor(normalColor, for: .normal)
        button.setTitleColor(highlightedColor, for: .highlighted)
        button.setImage(image?.withRenderingMode(.alwaysOriginal).withTintColor(normalColor), for: .normal)
        button.setImage(image?.withRenderingMode(.alwaysOriginal).withTintColor(highlightedColor), for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .leading
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 28, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(showWritingExam), for: .touchUpInside)
        return button
    }()

    private let loaderView: UIActivityIndicatorView = {
        let loaderView = UIActivityIndicatorView()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.style = .large
        loaderView.hidesWhenStopped = true
        return loaderView
    }()

    private let viewModel: CourseItemsViewModelProtocol
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: CourseItemsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        viewModel.reloadTableView
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
            
        viewModel.showError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showErrorAlert(message: errorMessage)
            }
            .store(in: &cancellables)
            
        viewModel.isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.loaderView.startAnimating()
                } else {
                    self?.loaderView.stopAnimating()
                }
            }
            .store(in: &cancellables)
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
        tableView.tableFooterView = footerView
        view.addSubview(tableView)
        view.addSubview(loaderView)
    }

    override func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default
        ))
        
        present(alert, animated: true)
    }

    @objc
    private func showWritingExam() {
        viewModel.showWritingExam()
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
        let url = viewModel.courseItems[indexPath.row].videoURL
        let controller = YouTubePlayerViewController()
        controller.url = url ?? ""

        
        navigationController?.present(controller, animated: true)
    }

}

import WebKit

class YouTubePlayerViewController: BaseViewController {
    var url: String? = ""
    private var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadYouTubeVideo()
    }

    func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.scrollView.isScrollEnabled = false
        view.addSubview(webView)
    }

    func loadYouTubeVideo() {
        let videoID = extractYouTubeID(from: url ?? "")

        if videoID != nil {
            let embedHTML = """
        <html>
        <body style="margin:0">
        <iframe width="100%" height="100%" src="https://www.youtube.com/embed/\(videoID ?? "")?playsinline=1&modestbranding=1&rel=0&showinfo=0" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
        </body>
        </html>
        """
            webView.loadHTMLString(embedHTML, baseURL: nil)

        } else {
            if let url = URL(string: url ?? "") {
                let request = URLRequest(url: url)
                webView.load(request)
            }
        }
    }

    override func addSubviews() {
        // You can add more custom subviews here if needed
    }

    override func setConstraints() {
        // If you move away from frame-based layout, apply constraints here
    }

    private func extractYouTubeID(from urlString: String) -> String? {
        guard let url = URL(string: urlString) else { return nil }

        if url.host?.contains("youtu.be") == true {
            return url.pathComponents.last
        }

        if url.host?.contains("youtube.com") == true {
            if url.path.contains("/watch") {
                return URLComponents(string: urlString)?
                    .queryItems?
                    .first(where: { $0.name == "v" })?
                    .value
            } else if url.path.contains("/shorts/") {
                return url.pathComponents.last
            }
        }

        return nil
    }
}

