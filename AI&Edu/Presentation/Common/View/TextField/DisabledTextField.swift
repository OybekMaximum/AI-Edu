//
//  DisabledTextField.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/04/25.
//

import UIKit

class DisabledInputTextField: InputTextField {
    override func gestureRecognizerShouldBegin(
        _ gestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        if gestureRecognizer.name == "Tap" {
            return true
        }
        return false
    }

    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning = self.beginningOfDocument
        let end = self.position(from: beginning, offset: self.text?.count ?? 0)
        return end
    }
}

