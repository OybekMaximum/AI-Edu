//
//  AuthController.swift
//  AI&Edu
//
//  Created by Oybek To’laboyev on 14/04/25.
//

import UIKit
import Combine

final class AuthViewController: BaseViewController {
    // MARK: - Properties
    // UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.fill.checkmark")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var authTitleLabel: UILabel = {
        let label = UILabel()
        label.font = InterFont.bold.font(size: 30)
        label.text = "Enter your informations"
        label.textColor = Colors.contentPrimary.color
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var authDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = InterFont.medium.font(size: 14)
        label.text = "To register and access your profile!"
        label.textColor = Colors.contentSecondary.color
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var loginTextField: InputTextField = {
        let textField = InputTextField()
        textField.update(inputState: .default)
        textField.returnKeyType = .next
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var emailTextField: InputTextField = {
        let textField = InputTextField()
        textField.update(inputState: .default)
        textField.returnKeyType = .next
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: InputTextField = {
        let textField = InputTextField()
        textField.update(inputState: .default)
        textField.returnKeyType = .next
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var reEnterPasswordTextField: InputTextField = {
        let textField = InputTextField()
        textField.update(inputState: .default)
        textField.returnKeyType = .next
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    // StackView for TextFields
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var loginPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = InterFont.medium.font(size: 16)
        label.textColor = Colors.contentTertiary.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var emailPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = InterFont.medium.font(size: 16)
        label.textColor = Colors.contentTertiary.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var passwordPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = InterFont.medium.font(size: 16)
        label.textColor = Colors.contentTertiary.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var reEnterPasswordPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Re-enter Password"
        label.font = InterFont.medium.font(size: 16)
        label.textColor = Colors.contentTertiary.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var doneButton: BaseButton = {
        let button = BaseButton()
        button.update(state: .press)
        button.setTitle("Done", for: .normal)
        button.addTarget(
            self,
            action: #selector(doneButtonTapped),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var privacyDescriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isEditable = false
        textView.font = InterFont.regular.font(size: 12)
        textView.delegate = self
        textView.backgroundColor = .clear
        textView.text = "By entering your phone number, you accept the terms of the user agreement and the personal data processing policy"
        textView.textColor = Colors.contentSecondary.color
        textView.textAlignment = .center
        textView.dataDetectorTypes = .link
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private var cancellables = Set<AnyCancellable>()
    private let viewModel: AuthViewModelProtocol
    private var isInSignUpState = true

    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func initialize() {
        setupAppearance()
        addSubviews()
        setConstraints()
        updateUIForAuthState(animated: false)
        setupTextFieldNotifications() // Add this
    }

    deinit {
        removeTextFieldNotifications() // Add this
    }

    override func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [loginTextField, emailTextField, passwordTextField, reEnterPasswordTextField].forEach {
            textFieldsStackView.addArrangedSubview($0)
        }

        [skipButton, logoImageView, authTitleLabel, authDescriptionLabel,
         textFieldsStackView, doneButton, privacyDescriptionTextView].forEach {
            contentView.addSubview($0)
        }

        loginTextField.addSubview(loginPlaceholderLabel)
        emailTextField.addSubview(emailPlaceholderLabel)
        passwordTextField.addSubview(passwordPlaceholderLabel)
        reEnterPasswordTextField.addSubview(reEnterPasswordPlaceholderLabel)
    }

    override func setConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 800) // Ensure scrollability
        ])

        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            skipButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 64),
            logoImageView.heightAnchor.constraint(equalToConstant: 64),

            authTitleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 24),
            authTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            authTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            authDescriptionLabel.topAnchor.constraint(equalTo: authTitleLabel.bottomAnchor, constant: 8),
            authDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            authDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            textFieldsStackView.topAnchor.constraint(equalTo: authDescriptionLabel.bottomAnchor, constant: 24),
            textFieldsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            textFieldsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

            loginTextField.heightAnchor.constraint(equalToConstant: 56),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            reEnterPasswordTextField.heightAnchor.constraint(equalToConstant: 56),

            doneButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 32),
            doneButton.leadingAnchor.constraint(equalTo: textFieldsStackView.leadingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: textFieldsStackView.trailingAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 56),

            privacyDescriptionTextView.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 24),
            privacyDescriptionTextView.leadingAnchor.constraint(equalTo: textFieldsStackView.leadingAnchor),
            privacyDescriptionTextView.trailingAnchor.constraint(equalTo: textFieldsStackView.trailingAnchor),
            privacyDescriptionTextView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -40) // Use lessThanOrEqualTo for flexible bottom
        ])

        NSLayoutConstraint.activate([
            loginPlaceholderLabel.centerYAnchor.constraint(equalTo: loginTextField.centerYAnchor),
            loginPlaceholderLabel.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor, constant: 16),
            loginPlaceholderLabel.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor, constant: -16),

            emailPlaceholderLabel.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            emailPlaceholderLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 16),
            emailPlaceholderLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: -16),

            passwordPlaceholderLabel.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordPlaceholderLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 16),
            passwordPlaceholderLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16),

            reEnterPasswordPlaceholderLabel.centerYAnchor.constraint(equalTo: reEnterPasswordTextField.centerYAnchor),
            reEnterPasswordPlaceholderLabel.leadingAnchor.constraint(equalTo: reEnterPasswordTextField.leadingAnchor, constant: 16),
            reEnterPasswordPlaceholderLabel.trailingAnchor.constraint(equalTo: reEnterPasswordTextField.trailingAnchor, constant: -16)
        ])
    }

    override func setupAppearance() {
        super.setupAppearance()

    }

    @objc private func skipButtonTapped() {
        isInSignUpState.toggle()
        updateUIForAuthState(animated: true)
    }

    private func updateUIForAuthState(animated: Bool) {
        let duration = animated ? 0.3 : 0.0
        skipButton.setTitle(isInSignUpState ? "Sign In" : "Sign Up", for: .normal)
        authTitleLabel.text = isInSignUpState ? "Enter your informations" : "Welcome Back!"
        authDescriptionLabel.text = isInSignUpState ? "To register and access your profile!" : "Sign in to continue."
        doneButton.setTitle(isInSignUpState ? "Done" : "Sign In", for: .normal)

        UIView.animate(withDuration: duration, animations: {
            let signUpFieldsAlpha: CGFloat = self.isInSignUpState ? 1.0 : 0.0
            let signUpFieldsHidden = !self.isInSignUpState

            self.emailTextField.isHidden = signUpFieldsHidden
            self.emailTextField.alpha = signUpFieldsAlpha
            // Placeholder visibility for emailTextField is handled by its own logic now

            self.reEnterPasswordTextField.isHidden = signUpFieldsHidden
            self.reEnterPasswordTextField.alpha = signUpFieldsAlpha
            // Placeholder visibility for reEnterPasswordTextField is handled by its own logic now

            self.view.layoutIfNeeded()
        })
    }

    // MARK: - Text Field Notifications
    private func setupTextFieldNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: loginTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: emailTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: passwordTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: reEnterPasswordTextField)
    }

    private func removeTextFieldNotifications() {
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    }

    @objc private func textFieldTextDidChange(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        updatePlaceholderVisibility(for: textField, animated: true)
    }

    private func getPlaceholderLabel(for textField: UITextField) -> UILabel? {
        switch textField {
        case loginTextField: return loginPlaceholderLabel
        case emailTextField: return emailPlaceholderLabel
        case passwordTextField: return passwordPlaceholderLabel
        case reEnterPasswordTextField: return reEnterPasswordPlaceholderLabel
        default: return nil
        }
    }

    private func updatePlaceholderVisibility(for textField: UITextField, animated: Bool) {
        guard let placeholderLabel = getPlaceholderLabel(for: textField) else { return }
        let isEmpty = textField.text?.isEmpty ?? true
        let targetAlpha: CGFloat = isEmpty ? 1.0 : 0.0

        if animated {
            UIView.animate(withDuration: 0.2) {
                placeholderLabel.alpha = targetAlpha
            }
        } else {
            placeholderLabel.alpha = targetAlpha
        }
    }
}

// MARK: - Private methods
private extension AuthViewController {
    @objc func doneButtonTapped() {
        if isInSignUpState {
            print("Attempting Sign Up...")
            // viewModel.signUp(...)
        } else {
            print("Attempting Sign In...")
            // viewModel.signIn(...)
        }
        viewModel.showMain()
    }
}

// MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Update InputTextField state (e.g., border)
        (textField as? InputTextField)?.update(inputState: .active)

        // Update placeholder visibility based on current text, possibly animated
        updatePlaceholderVisibility(for: textField, animated: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Update InputTextField state (e.g., border)
        (textField as? InputTextField)?.update(inputState: .default)

        // Update placeholder visibility based on final text, possibly animated
        updatePlaceholderVisibility(for: textField, animated: true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case loginTextField:
            if isInSignUpState { emailTextField.becomeFirstResponder() }
            else { passwordTextField.becomeFirstResponder() }
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            if isInSignUpState { reEnterPasswordTextField.becomeFirstResponder() }
            else {
                textField.resignFirstResponder()
                doneButtonTapped()
            }
        case reEnterPasswordTextField:
            textField.resignFirstResponder()
            doneButtonTapped()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - UITextViewDelegate
extension AuthViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
