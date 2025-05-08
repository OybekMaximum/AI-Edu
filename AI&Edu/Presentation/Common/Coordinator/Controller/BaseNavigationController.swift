//
//  BaseNavigationController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 11/04/25.
//

import UIKit

open class BaseNavigationController: UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    open func initialize() {
//        let backIndicatorImage = Images.iconArrowLeft.image.withRenderingMode(.alwaysTemplate)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = Colors.backgroundPrimary.color.withAlphaComponent(0.85)
//        appearance.setBackIndicatorImage(backIndicatorImage, transitionMaskImage: backIndicatorImage)
        appearance.backgroundEffect = UIBlurEffect(style: .regular)
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.contentPrimary.color,
            NSAttributedString.Key.font: Fonts.Inter.bold.font(size: 16)
        ]
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = Colors.contentPrimary.color
    }
}

