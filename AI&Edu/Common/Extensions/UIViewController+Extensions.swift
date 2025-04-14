//
//  UIViewController+Extensions.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import UIKit

extension UIViewController {
    public final func hideKeyboardOnTap(cancelsTouchesInView: Bool = false) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        tapGesture.cancelsTouchesInView = cancelsTouchesInView
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }

    public func hideKeyboard() {
        view.endEditing(true)
    }

    @objc private func hideKeyboardAction() {
        hideKeyboard()
    }
}

extension UIViewController {
    func setAsRootViewController(to window: UIWindow, animated: Bool) {
        guard animated, let snapshot = window.snapshotView(afterScreenUpdates: true) else {
            window.rootViewController = self
            window.makeKeyAndVisible()
            return
        }

        view.addSubview(snapshot)
        window.rootViewController = self
        window.makeKeyAndVisible()

        UIView.animate(withDuration: 0.3, animations: {
            snapshot.layer.opacity = 0
        }, completion: { _ in
            snapshot.removeFromSuperview()
        })
    }
}
