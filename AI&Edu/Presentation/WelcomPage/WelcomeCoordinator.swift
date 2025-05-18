//
//  FirstWelcomeCoordinator.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 16/05/25.
//

import UIKit

protocol FirstWelcomeCoordinatorDelegate: CoordinatorDelegate {
    func showNext()
    func showWritingTest()
    func showHome()
}

class FirstWelcomeCoordinator: BaseCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window

        super.init()
    }

    override func start() {
        let controller = FirstWelcomeController()
        controller.coordinatorDelegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension FirstWelcomeCoordinator: FirstWelcomeCoordinatorDelegate {
    func showNext() {
        let controller = SecondWelcomeController()
        controller.coordinatorDelegate = self
        navigationController.pushViewController(controller, animated: false)
    }

    func showWritingTest() {
        let controller = AICheckKnowledgeController()
        controller.coordinatorDelegate = self
        navigationController.present(controller, animated: true)
    }

    func showHome() {
        appCoordinator?.showMainPage()
    }
}

extension FirstWelcomeCoordinator {
    private var appCoordinator: AppCoordinator? {
        var parentCoordinator = parentCoordinator
        while let coordinator = parentCoordinator?.parentCoordinator {
            parentCoordinator = coordinator
        }

        return parentCoordinator as? AppCoordinator
    }
}


import WebKit

class AICheckKnowledgeController: BaseViewController {
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
        if let url = URL(string: "https://www.ambitiousimpact.com/quiz") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    override func addSubviews() {

    }

    override func setConstraints() {

    }
}
