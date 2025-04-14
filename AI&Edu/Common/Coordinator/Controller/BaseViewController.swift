//
//  BaseViewController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 11/04/25.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - ViewController lifecycle
    override init(
        nibName nibNameOrNil: String?,
        bundle nibBundleOrNil: Bundle?
    ) {
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

    // MARK: Base methods
    func initialize() {}

    /// Super method should be called when overridden
    func setupAppearance() {
        navigationItem.hidesBackButton = true
        navigationItem.backButtonTitle = ""
        view.backgroundColor = Colors.backgroundPrimary.color
    }

    func addSubviews() {
        fatalError("addSubviews() has not been implemented")
    }

    func setConstraints() {
        fatalError("setConstraints() has not been implemented")
    }


    /// Should be overriden in order to update language
    func updateLanguage() {}

    func registerLanguageNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateLanguageAction),
            name: .languageChanged,
            object: nil
        )
    }

    // MARK: Notification methods
    /// Adds keyboard show and hide observers, "keyboardShowAction" and "keyboardHideAction" method should be implemented
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

    /// Removes keyboard show and hide observers
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    func keyboardShowAction(_ keyboardFrame: CGRect) {
        fatalError("keyboardShowAction has not been implemented")
    }

    func keyboardHideAction(_ keyboardFrame: CGRect) {
        fatalError("keyboardHideAction has not been implemented")
    }

    func keyboardFrame(notification: Notification) -> CGRect {
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo?[
            UIResponder.keyboardFrameEndUserInfoKey
        ] as? CGRect
        return keyboardFrame ?? .zero
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

