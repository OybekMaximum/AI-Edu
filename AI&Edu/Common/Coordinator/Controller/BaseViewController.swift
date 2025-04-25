//
//  BaseViewController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 11/04/25.
//

import UIKit

class BaseViewController: UIViewController {
    private let gradientLayer = CAGradientLayer()

    // MARK: - ViewController lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        registerLanguageNotifications()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerLanguageNotifications()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds // Ensure gradient fills view after layout
    }

    // MARK: Base methods
    func initialize() {
        setupAppearance()
        addSubviews()
        setConstraints()
    }

    func setupAppearance() {
        navigationItem.hidesBackButton = true
        navigationItem.backButtonTitle = ""

        setupWowGradientBackground()
    }

    func addSubviews() {
        fatalError("addSubviews() has not been implemented")
    }

    func setConstraints() {
        fatalError("setConstraints() has not been implemented")
    }

    func updateLanguage() {}

    func registerLanguageNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateLanguageAction),
            name: .languageChanged,
            object: nil
        )
    }

    func addKeyboardOberservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func keyboardShowAction(_ keyboardFrame: CGRect) {
        fatalError("keyboardShowAction has not been implemented")
    }

    func keyboardHideAction(_ keyboardFrame: CGRect) {
        fatalError("keyboardHideAction has not been implemented")
    }

    func keyboardFrame(notification: Notification) -> CGRect {
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        return keyboardFrame ?? .zero
    }

    // MARK: - Gradient background
    private func setupWowGradientBackground() {
        gradientLayer.colors = [
            UIColor(red: 0.98, green: 0.42, blue: 0.89, alpha: 1).cgColor, // Neon Pink
            UIColor(red: 0.41, green: 1.0, blue: 0.76, alpha: 1).cgColor,  // Mint Green
            UIColor(red: 0.42, green: 0.78, blue: 0.98, alpha: 1).cgColor, // Sky Blue
//            UIColor(red: 1.0, green: 0.77, blue: 0.36, alpha: 1).cgColor    Peachy Orange
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.cornerRadius = 0
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)

        // Sexy glow effect
        view.layer.shadowColor = UIColor.systemPink.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 25
        view.layer.shadowOffset = CGSize(width: 0, height: 15)
    }
}

// MARK: - Private methods
private extension BaseViewController {
    @objc func updateLanguageAction() {
        updateLanguage()
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        let frame = keyboardFrame(notification: notification)
        keyboardShowAction(frame)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        let frame = keyboardFrame(notification: notification)
        keyboardHideAction(frame)
    }
}
