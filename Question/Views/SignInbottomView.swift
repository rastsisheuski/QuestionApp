//
//  SignInbottomView.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

class SignInBottomView: KeyboardObserver {
    
    // MARK: -
    // MARK: - Public Properties
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Войти в аккаунт"
        label.font = UIFont.systemFont(ofSize: Constants.LoginBottomView.titleFontSize, weight: .bold)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 15
        stackView.axis = .vertical
        return stackView
    }()
    
    let emailView: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .email)
        view.textField.keyboardType = .emailAddress
        view.textField.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordView: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .password)
        view.textField.isSecureTextEntry = true
        view.textField.keyboardType = .namePhonePad
        view.textField.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Забыли пароль?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.LoginBottomView.forgotPasswordFontSize, weight: .thin)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let enterButton: ConfirmRegistrationButton = {
        let button = ConfirmRegistrationButton(title: "Войти")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let accountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Нету аккаунта?"
        label.font = UIFont.systemFont(ofSize: Constants.LoginBottomView.registrationAccountFontSize, weight:  .thin)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .right
        return label
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Регистрация", for: .normal)
        button.setTitleColor(Colors.General.selectedButton, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.LoginBottomView.registrationAccountFontSize, weight: .thin)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    // MARK: -
    // MARK: - Private Properties
    
    private var firstAppear = true
    
    // MARK: -
    // MARK: - LifeCycle
    
    init(frame: CGRect) {
        super .init(scrollView: scrollView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if firstAppear {
            setupView()
            layoutElements()
            firstAppear = false
        }
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func checkValidateState() {
        emailView.textField.checkValidStateOfTextField()
        passwordView.textField.checkValidStateOfTextField()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupView() {
        setGradientBackground()
        layer.cornerRadius = 20
        clipsToBounds = true
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func layoutElements() {
        layoutScrollView()
        layoutTitleLabel()
        layoutStackView()
        layoutForgotPasswordButton()
        layoutEnterButton()
        layoutHorizontalStackView()
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        scrollView.fillSuperview()
    }
    
    private func layoutTitleLabel() {
        scrollView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutStackView() {
        stackView.addArrangedSubview(emailView)
        stackView.addArrangedSubview(passwordView)
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func layoutForgotPasswordButton() {
        scrollView.addSubview(forgotPasswordButton)
        
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.General.defaultSpacing),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant:  -Constants.General.defaultSpacing),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func layoutEnterButton() {
        scrollView.addSubview(enterButton)
        
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 16),
            enterButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            enterButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutHorizontalStackView() {
        scrollView.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(accountLabel)
        horizontalStackView.addArrangedSubview(registrationButton)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: Constants.General.defaultSpacing),
            horizontalStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            horizontalStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
}
