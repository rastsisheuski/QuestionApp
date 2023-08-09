//
//  RegistrationViewControllerView.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

class RegistrationViewControllerView: UIView {
     
    // MARK: -
    // MARK: - Public Properties
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.SignIn.signInBackgroundImage.image
        return imageView
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = .white
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Регистрация"
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var nameTextField: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .name)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textField.keyboardType = .alphabet
        view.textField.tintColor = .lightGray
        return view
    }()
    
    lazy var emailTextField: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .email)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textField.keyboardType = .emailAddress
        view.textField.tintColor = .lightGray
        return view
    }()
    
    lazy var passwordTextField: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .password)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textField.keyboardType = .namePhonePad
        view.textField.tintColor = .lightGray
        return view
    }()
    
    lazy var confirmPasswordTextField: AuthTextFieldView = {
        let view = AuthTextFieldView(type: .password)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textField.keyboardType = .namePhonePad
        view.textField.tintColor = .lightGray
        return view
    }()
    
    lazy var signInButton: LoginButton = {
        let button = LoginButton(
            title: "Войти",
            titleColor: .white,
            size: Constants.General.baseButtonFontSize,
            backgroundColor: Colors.signIn.logInBottomColor,
            border: false,
            image: .none,
            shadow: true
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var alreadyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Уже есть аккаунт? Войти"
        label.font = UIFont.systemFont(ofSize: Constants.General.baseLabelFontSize)
        label.textColor = .white
        label.underlineText(
            firstRange: "Войти",
            fontSize: Constants.General.baseLabelFontSize,
            weight: .bold,
            color: .purple
        )
        label.textAlignment = .center
        return label
    }()
    
    // MARK: -
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupUI()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = .white
    }
    
    private func layoutElements() {
        layoutBackgroundImage()
        layoutBackButton()
        layoutScrollView()
        layoutTitleLabel()
        layoutStackView()
        layoutSignInButon()
        layoutAlreadyHaveAccountLabel()
    }
    
    private func layoutBackgroundImage() {
        addSubview(backgroundImageView)
        
        backgroundImageView.fillSuperview()
    }
    
    private func layoutBackButton() {
        addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,  constant:  Constants.General.defaultSpacing),
            backButton.heightAnchor.constraint(equalToConstant: Constants.Registration.backButtonHeightConstraint),
            backButton.widthAnchor.constraint(equalTo: backButton.heightAnchor, multiplier: 1)
        ])
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Constants.General.defaultSpacing),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func layoutTitleLabel() {
        scrollView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: Constants.Registration.titleLabelTopConstraint),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutStackView() {
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(confirmPasswordTextField)
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Registration.baseConstraint / 2),
            stackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            stackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutSignInButon() {
        scrollView.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Constants.Registration.baseConstraint),
            signInButton.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            signInButton.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
    private func layoutAlreadyHaveAccountLabel() {
        scrollView.addSubview(alreadyHaveAccountLabel)
        
        NSLayoutConstraint.activate([
            alreadyHaveAccountLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: Constants.Registration.baseConstraint),
            alreadyHaveAccountLabel.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: Constants.General.defaultSpacing),
            alreadyHaveAccountLabel.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -Constants.General.defaultSpacing),
            alreadyHaveAccountLabel.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
}
