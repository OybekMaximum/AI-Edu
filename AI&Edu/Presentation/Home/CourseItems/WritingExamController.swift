//
//  WritingExamController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 03/06/25.
//

import Foundation
import WebKit

class WritingExamController: BaseViewController {
    weak var coordinatorDelegate: FirstWelcomeCoordinatorDelegate?
    var webView: WKWebView!

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinatorDelegate?.showHome()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadURL()
    }

    func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
    }

    func loadURL() {
        if let url = URL(string: "http://13.53.216.88/submit") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    override func addSubviews() {

    }

    override func setConstraints() {

    }
}
