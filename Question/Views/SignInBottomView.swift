//
//  SignInBottomView.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 16.07.23.
//

import UIKit

class SignInBottomView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var orLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "или"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var emailView: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .email)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textField.keyboardType = .emailAddress
        view.textField.tintColor = .lightGray
        return view
    }()
    
    lazy var passwordView: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .password)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textField.isSecureTextEntry = true
        view.textField.keyboardType = .namePhonePad
        view.textField.tintColor = .lightGray
        return view
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Забыли пароль?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    lazy var dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Нету аккаунта? Зарегистрироваться"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.underlineText(
            firstRange: "Зарегистрироваться",
            fontSize: 12,
            weight: .bold,
            color: .purple
        )
        return label
    }()
    
    lazy var signInButton: LoginButton = {
        let button = LoginButton(
            title: "Войти",
            titleColor: .white,
            size: 16,
            backgroundColor: Colors.signIn.logInbottomColor,
            border: false,
            image: .none,
            shadow: true
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: -
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    private func layoutElements() {
        layoutScrollView()
        layoutOrLabel()
        layoutStackView()
        layourForgotButton()
        layoutDontHaveAccountLabel()
        layoutSignInButton()
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        
        scrollView.fillSuperview()
    }
    
    private func layoutOrLabel() {
        scrollView.addSubview(orLabel)
        
        NSLayoutConstraint.activate([
            orLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            orLabel.leadingAnchor.constraint(equalTo:  scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            orLabel.trailingAnchor.constraint(equalTo:  scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutStackView() {
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layourForgotButton() {
        scrollView.addSubview(forgotPasswordButton)
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing),
        ])
    }
    
    private func layoutDontHaveAccountLabel() {
        scrollView.addSubview(dontHaveAccountLabel)
        
        NSLayoutConstraint.activate([
            dontHaveAccountLabel.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            dontHaveAccountLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    private func layoutSignInButton() {
        scrollView.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: dontHaveAccountLabel.bottomAnchor, constant: 30),
            signInButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            signInButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing),
            signInButton.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
