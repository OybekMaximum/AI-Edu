//
//  UILabel+Extensions.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 22/04/25.
//

import UIKit

extension UILabel {
    func styleAsTag(backgroundColor: UIColor = UIColor.systemPink.withAlphaComponent(0.2),
                    textColor: UIColor = .label,
                    cornerRadius: CGFloat = 8,
                    font: UIFont = Fonts.Inter.semiBold.font(size: 12)) {

        self.backgroundColor = backgroundColor
        self.textColor = textColor
//        self.textAlignment = .center
        self.numberOfLines = 1
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.font = font
    }

    func setTextWithPadding(_ text: String? = nil) {
        let paddedText = text.map { "   \($0)   " } ?? ""
        self.text = paddedText
    }
}
