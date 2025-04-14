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

    // Cancellable for bindings
    private var cancellables = Set<AnyCancellable>()

    private let viewModel: AuthViewModelProtocol

    // MARK: - ViewController lifecycle
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        loginTextField.becomeFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Base methods
    override func initialize() {
        setupAppearance()
        addSubviews()
        setConstraints()
    }

    override func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        [logoImageView, authTitleLabel, authDescriptionLabel, loginTextField,
         emailTextField, passwordTextField, reEnterPasswordTextField,
         doneButton, privacyDescriptionTextView].forEach {
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
            contentView.heightAnchor.constraint(equalToConstant: 1000)
        ])

        // Example constraints for UI elements
        NSLayoutConstraint.activate([
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

            loginTextField.topAnchor.constraint(equalTo: authDescriptionLabel.bottomAnchor, constant: 24),
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            loginTextField.heightAnchor.constraint(equalToConstant: 56),

            emailTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 56),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),

            reEnterPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            reEnterPasswordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            reEnterPasswordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            reEnterPasswordTextField.heightAnchor.constraint(equalToConstant: 56),

            doneButton.topAnchor.constraint(equalTo: reEnterPasswordTextField.bottomAnchor, constant: 32),
            doneButton.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 56),

            privacyDescriptionTextView.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 24),
            privacyDescriptionTextView.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            privacyDescriptionTextView.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            privacyDescriptionTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])

        NSLayoutConstraint.activate([
            // loginPlaceholderLabel
            loginPlaceholderLabel.topAnchor.constraint(equalTo: loginTextField.topAnchor, constant: 16),
            loginPlaceholderLabel.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor, constant: 16),
            loginPlaceholderLabel.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor, constant: -16),
            loginPlaceholderLabel.bottomAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: -16),

            // emailPlaceholderLabel
            emailPlaceholderLabel.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 16),
            emailPlaceholderLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: 16),
            emailPlaceholderLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor, constant: -16),
            emailPlaceholderLabel.bottomAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: -16),

            // passwordPlaceholderLabel
            passwordPlaceholderLabel.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 16),
            passwordPlaceholderLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: 16),
            passwordPlaceholderLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -16),
            passwordPlaceholderLabel.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: -16),

            // reEnterPasswordPlaceholderLabel
            reEnterPasswordPlaceholderLabel.topAnchor.constraint(equalTo: reEnterPasswordTextField.topAnchor, constant: 16),
            reEnterPasswordPlaceholderLabel.leadingAnchor.constraint(equalTo: reEnterPasswordTextField.leadingAnchor, constant: 16),
            reEnterPasswordPlaceholderLabel.trailingAnchor.constraint(equalTo: reEnterPasswordTextField.trailingAnchor, constant: -16),
            reEnterPasswordPlaceholderLabel.bottomAnchor.constraint(equalTo: reEnterPasswordTextField.bottomAnchor, constant: -16)
        ])
    }
}


// MARK: - Private methods
private extension AuthViewController {
    // MARK: @objc action methods
    @objc func doneButtonTapped() {
        viewModel.showMain()
    }
}

// MARK: - UITextFieldDelegate
extension AuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            (textField as? InputTextField)?.update(
                inputState: .active
            )

            switch textField {
            case self.loginTextField:
                self.loginPlaceholderLabel.alpha = 0
            case self.emailTextField:
                self.emailPlaceholderLabel.alpha = 0
            case self.passwordTextField:
                self.passwordPlaceholderLabel.alpha = 0
            case self.reEnterPasswordTextField:
                self.reEnterPasswordPlaceholderLabel.alpha = 0
            default:
                break
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
             (textField as? InputTextField)?.update(
                inputState: .default
             )

            guard textField.text?.isEmpty ?? true else { return }
            switch textField {
            case self.loginTextField:
                self.loginPlaceholderLabel.alpha = 1
            case self.emailTextField:
                self.emailPlaceholderLabel.alpha = 1
            case self.passwordTextField:
                self.passwordPlaceholderLabel.alpha = 1
            case self.reEnterPasswordTextField:
                self.reEnterPasswordPlaceholderLabel.alpha = 1
            default:
                break
            }
        }
    }
}

// MARK: - UITextViewDelegate
extension AuthViewController: UITextViewDelegate {
    func textView(
        _ textView: UITextView,
        shouldInteractWith textAttachment: NSTextAttachment,
        in characterRange: NSRange
    ) -> Bool {
        return true
    }
}
