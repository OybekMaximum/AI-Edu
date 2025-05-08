//
//  InputTextField.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 13/04/25.
//

import UIKit

protocol InputTextFieldDelegate: AnyObject {
    func textFieldDidChangeValue(_ textField: InputTextField)
}

class InputTextField: BaseTextField {
    // TextField's input state
    enum State {
        case disabled
        case active
        case error
        case `default`

        var backgroundColor: UIColor {
            switch self {
            case .disabled:
                UIColor.backgroundPrimary
            case .active:
                UIColor.backgroundPrimary
            case .error:
                UIColor.backgroundPrimary
            case .default:
                UIColor.backgroundPrimary
            }
        }

        var borderColor: UIColor {
            switch self {
            case .disabled:
                .clear
            case .active:
                UIColor.borderAccent
            case .error:
                UIColor.borderNegative
            case .default:
                UIColor.borderPrimary
            }
        }

        var textColor: UIColor {
            switch self {
            case .disabled:
                UIColor.contentSecondary
            case .active:
                UIColor.contentPrimary
            case .error:
                UIColor.contentPrimary
            case .default:
                UIColor.contentPrimary
            }
        }

        var shadowColor: UIColor {
            switch self {
            case .disabled:
                .clear
            case .active:
                UIColor.shadowAccent
            case .error:
                UIColor.shadowNegative
            case .default:
                .clear
            }
        }
    }

    // MARK: - Constants
    private enum Constants {
        static let deafultInset: CGFloat = 16
        static let cornerRadius: CGFloat = 16
        static let fontSize: CGFloat = 16
        static let borderWidth: CGFloat = 1
        static let shadowBlurRadius: CGFloat = 8
    }

    // MARK: - Properties
    private var inputState: State = .default {
        willSet {
            backgroundColor = newValue.backgroundColor
            textColor = newValue.textColor
            layer.borderColor = newValue.borderColor.cgColor
            layer.shadowColor = newValue.shadowColor.cgColor
            isEnabled = newValue != .disabled
        }
    }

    var isActive: Bool {
        return inputState == .active
    }

    weak var actionDelegate: InputTextFieldDelegate?

    // Base methods
    override func initialize() {
        addTarget(
            self,
            action: #selector(editingChangedAction),
            for: .editingChanged
        )
        setupAppearance()
    }

    override func setupAppearance() {
        font = InterFont.medium.font(size: Constants.fontSize)
    }

    // MARK: - Methods
    // overridden methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(
            by: UIEdgeInsets(
                top: Constants.deafultInset,
                left: Constants.deafultInset,
                bottom: Constants.deafultInset,
                right: Constants.deafultInset
            )
        )
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(
            by: UIEdgeInsets(
                top: Constants.deafultInset,
                left: Constants.deafultInset,
                bottom: Constants.deafultInset,
                right: Constants.deafultInset
            )
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
        layer.shadowRadius = Constants.shadowBlurRadius
        layer.shadowOpacity = 1
    }

    // Public methods
    func update(inputState: State) {
        self.inputState = inputState
    }

    func setPlaceholder(text: String) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .font: InterFont.medium.font(size: Constants.fontSize),
                .foregroundColor: UIColor.contentSecondary
            ]
        )
    }

    // Private methods
    @objc private func editingChangedAction() {
        actionDelegate?.textFieldDidChangeValue(self)
    }
}

