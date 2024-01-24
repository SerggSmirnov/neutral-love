//
//  SignInView.swift
//  neutral.love
//
//  Created by Philipp Zeppelin on 21.10.2023.
//

import UIKit

protocol SignInViewDelegate: AnyObject {
    func signInButtonPressed()
    func signUpButtonPressed()
}

final class SignInView: UIView {
    weak var delegate: SignInViewDelegate?

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let loginView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = Constants.elementsCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Resources.Strings.AuthorizationModule.emailText
        textField.textColor = .label
        textField.layer.cornerRadius = Constants.elementsCornerRadius
        textField.addPaddingToTextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Resources.Strings.AuthorizationModule.passwordAsterisksText
        textField.textColor = .label
        textField.layer.cornerRadius = Constants.elementsCornerRadius
        textField.addPaddingToTextField()
        textField.backgroundColor = .secondarySystemBackground
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var signInButton = {
        let button = UIButton()
        button.setTitle(Resources.Strings.AuthorizationModule.signInButtonText, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Resources.Fonts.arial17
        button.layer.cornerRadius = Constants.elementsCornerRadius
        button.backgroundColor = Resources.Colors.AuthorizationModule.signButtonsColor
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var signUpButton = {
        let button = UIButton()
        button.setTitle(Resources.Strings.AuthorizationModule.signUpButtonText, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = Resources.Fonts.arial17
        button.layer.cornerRadius = Constants.elementsCornerRadius
        button.backgroundColor = Resources.Colors.AuthorizationModule.signButtonsColor
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let signButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.AuthorizationModule.emailText
        label.font = Resources.Fonts.arial17
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.AuthorizationModule.passwordText
        label.font = Resources.Fonts.arial17
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.AuthorizationModule.dontHaveAnAccountText
        label.font = Resources.Fonts.arial12
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearence()
        embedViews()
        setupScrollViewConstraints()
        setupBackgroundViewConstraints()
        setupLoginViewConstraints()
        setupEmailTextFieldConstraints()
        setupPasswordTextFieldConstraints()
        setupSignButtonsStackViewConstraints()
        addingButtonsToStackView()
        setupLoginLabelConstraints()
        setupPasswordLabelConstraints()
        setupDontHaveAccountLabelConstraints()
        registerKeyBoardNotification()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeKeyboardNotification()
    }

    private func addingButtonsToStackView() {
        signButtonsStackView.addArrangedSubview(signInButton)
        signButtonsStackView.addArrangedSubview(signUpButton)
    }

    @objc
    private func signInButtonTapped() {
        delegate?.signInButtonPressed()
    }

    @objc
    private func signUpButtonTapped() {
        delegate?.signUpButtonPressed()
    }
}

// MARK: - Configuring View

extension SignInView {
    private func setupAppearence() {
        layer.cornerRadius = Constants.elementsCornerRadius
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension SignInView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Offset content

private extension SignInView {
    func registerKeyBoardNotification() {
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

    @objc
    func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo

        guard let keyboardHeight = (
            userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        )?.cgRectValue else {
            return
        }

        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2.5)
    }

    @objc
    func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }

    func removeKeyboardNotification() {
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
}

// MARK: - Setup View and Constraints

private extension SignInView {
    func embedViews() {
        addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(loginView)

        [
            emailTextField,
            passwordTextField,
            signButtonsStackView,
            emailLabel,
            passwordLabel,
            dontHaveAccountLabel
        ].forEach { loginView.addSubview($0) }
    }

    func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setupBackgroundViewConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    func setupLoginViewConstraints() {
        NSLayoutConstraint.activate([
            loginView.heightAnchor.constraint(equalToConstant: 260),
            loginView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            loginView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: Constants.signInViewPadding),
            backgroundView.rightAnchor.constraint(equalTo: loginView.rightAnchor, constant: Constants.signInViewPadding)
        ])
    }

    func setupEmailTextFieldConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldsHeight),
            emailTextField.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 50),
            emailTextField.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: Constants.viewElementsPadding),
            loginView.rightAnchor.constraint(equalTo: emailTextField.rightAnchor, constant: Constants.viewElementsPadding)
        ])
    }

    func setupPasswordTextFieldConstraints() {
        NSLayoutConstraint.activate([
            passwordTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldsHeight),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: Constants.elementsHeightWithEachOther),
            passwordTextField.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: Constants.viewElementsPadding),
            loginView.rightAnchor.constraint(equalTo: passwordTextField.rightAnchor, constant: Constants.viewElementsPadding)
        ])
    }

    func setupSignButtonsStackViewConstraints() {
        NSLayoutConstraint.activate([
            signButtonsStackView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: Constants.elementsHeightWithEachOther),
            signButtonsStackView.leftAnchor.constraint(equalTo: loginView.leftAnchor, constant: Constants.viewElementsPadding),
            loginView.rightAnchor.constraint(equalTo: signButtonsStackView.rightAnchor, constant: Constants.viewElementsPadding)
        ])
    }

    func setupLoginLabelConstraints() {
        NSLayoutConstraint.activate([
            emailLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: Constants.labelsTop),
            emailLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: Constants.viewElementsPadding)
        ])
    }

    func setupPasswordLabelConstraints() {
        NSLayoutConstraint.activate([
            passwordLabel.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: Constants.labelsTop),
            passwordLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: Constants.viewElementsPadding)
        ])
    }

    func setupDontHaveAccountLabelConstraints() {
        NSLayoutConstraint.activate([
            dontHaveAccountLabel.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: Constants.labelsTop),
            dontHaveAccountLabel.leadingAnchor.constraint(equalTo: signUpButton.leadingAnchor)
        ])
    }
}

// MARK: - Setting Constants

extension SignInView {
    private enum Constants {
        static let textFieldsHeight: CGFloat = 40
        static let viewElementsPadding: CGFloat = 20
        static let elementsHeightWithEachOther: CGFloat = 30
        static let labelsTop: CGFloat = -3
        static let elementsCornerRadius: CGFloat = 10
        static let signInViewPadding: CGFloat = 43
    }
}
