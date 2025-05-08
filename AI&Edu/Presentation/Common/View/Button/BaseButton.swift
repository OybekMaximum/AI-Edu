//
//  BaseButton.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/04/25.
//

import UIKit

class BaseButton: UIButton {
    // Button's state
    enum State {
        case disabled
        case press
        case `default`
        case deactivate

        var backgroundColor: [CGColor] {
            switch self {
            case .disabled:
                [Colors.backgroundInverseDisabled.color.cgColor,
                 Colors.backgroundInverseDisabled.color.cgColor]
            case .press:
                // TODO: Add hexes to Colors assets
                [UIColor(hex: "#20FF8A").cgColor,
                 UIColor(hex: "#20FF8A").cgColor]
            case .default:
                [Colors.backgroundInverseSecondary.color.cgColor,
                 Colors.backgroundInverseSecondary.color.cgColor]
            case .deactivate:
                [Colors.backgroundInverseSecondary.color.cgColor,
                 Colors.backgroundInverseSecondary.color.cgColor]
            }
        }

        var textColor: UIColor {
            switch self {
            case .disabled:
                Colors.contentInverseDisabled.color
            case .press:
                Colors.commonBlack.color
            case .default:
                Colors.contentPrimary.color
            case .deactivate:
                Colors.contentNegative.color
            }
        }
    }

    // MARK: - Properties
    // Button state
    private var buttonState: State = .disabled {
        willSet {
            UIView.animate(withDuration: 0.2) {
                self.setTitleColor(newValue.textColor, for: .normal)
                self.gradient.colors = newValue.backgroundColor
            } completion: { _ in
                self.isEnabled = newValue != .disabled
            }
        }
    }

    private let feedbackGenerator: UIImpactFeedbackGenerator = {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)
        feedbackGenerator.prepare()
        return feedbackGenerator
    }()

    // Button gradient
    private let gradient: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        layer.cornerRadius = 16
        return layer
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = Colors.commonBlack.color
        indicator.isHidden = true
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    private var isAnimating = false
    private var originalTitle: String?

    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.bounds
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            update(state: buttonState)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateButton()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        releaseAnimation()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        releaseAnimation()
    }

    // Public methods
    func update(state: State) {
        self.buttonState = state
    }

    func startLoading() {
        guard !isAnimating else { return }
        isAnimating = true
        isEnabled = false
        originalTitle = title(for: .normal)
        setTitle("", for: .normal)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func stopLoading() {
        guard isAnimating else { return }
        isAnimating = false
        isEnabled = true
        activityIndicator.stopAnimating()
        setTitle(originalTitle, for: .normal)
        originalTitle = nil
    }
}

// MARK: - BaseButton
private extension BaseButton {
    func setUp() {
        titleLabel?.font = InterFont.semiBold.font(size: 14)
        titleLabel?.textAlignment = .center
        layer.cornerRadius = 16
        layer.insertSublayer(gradient, at: 0)

        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func releaseAnimation() {
        UIView.animate(
            withDuration: 0.15,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: [.curveEaseOut, .allowUserInteraction]
        ) {
            self.transform = .identity
            self.alpha = 1.0
        } completion: { [weak self] _ in
            self?.feedbackGenerator.prepare()
        }
    }

    @inline(__always)
    func animateButton() {
        feedbackGenerator.impactOccurred()
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: [.curveEaseOut, .allowUserInteraction]
        ) {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            self.alpha = 0.8
        }
    }
}
