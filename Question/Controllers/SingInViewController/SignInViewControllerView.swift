//
//  SignInViewControllerView.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

class SignInViewControllerView: UIView {
    
    // MARK: -
    // MARK: - Public Properties
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.SignIn.backgroundImage.image
        return imageView
    }()
    
    lazy var topWaveImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = Images.SignIn.topWaveImage.image
        return imageview
    }()
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Images.SignIn.mainImage.image
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var appleIDSignInButton: LoginButton = {
        let button = LoginButton(
            title: "Войти с помощью AppleID",
            titleColor: .white,
            size: 12,
            backgroundColor: .black,
            border: false,
            image: Images.SignIn.appleImage.image,
            shadow: true
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var googleSignInButton: LoginButton = {
        let button = LoginButton(
            title: "Войти с помощью Google",
            titleColor: .black,
            size: 12,
            backgroundColor: .white,
            border: true,
            image: Images.SignIn.googleImage.image,
            shadow: true
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var signInWithEmailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "или войдите с помощью email"
        label.underlineText(
            firstRange: "или войдите с помощью email",
            fontSize: 12,
            weight: .regular,
            color: .white
        )
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var alreayHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.text = "Уже есть аккаунт? Войти"
        label.underlineText(
            firstRange: "Войти",
            fontSize: 12,
            weight: .bold,
            color: .purple
        )
        return label
    }()
    
    lazy var bottomView: SignInBottomView = {
        let view = SignInBottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    lazy var bottomWaveImageView: UIImageView = {
//        let imageview = UIImageView()
//        imageview.translatesAutoresizingMaskIntoConstraints = false
//        imageview.image = Images.SignIn.bottomWaveImage.image
//        return imageview
//    }()
    
    // MARK: -
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        layoutElements()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupUI() {
        backgroundColor = .white
        bottomView.isHidden = true
    }
    
    private func layoutElements() {
        layoutBackgroundImage()
        layoutTopWaveImage()
        layoutMainImageView()
        layoutStackView()
//        layoutBottomWaveImageView()
        layoutSignInWithEmailLabel()
        layoutAlreayHaveAccountLabel()
        layoutBottomView()
    }
    
    private func layoutBackgroundImage() {
        addSubview(backgroundImageView)
        
        backgroundImageView.fillSuperview()
    }
    
    private func layoutTopWaveImage() {
        addSubview(topWaveImageView)
        
        NSLayoutConstraint.activate([
            topWaveImageView.topAnchor.constraint(equalTo: topAnchor),
            topWaveImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topWaveImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            topWaveImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
        ])
    }
    
    private func layoutMainImageView() {
        addSubview(mainImageView)
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: topWaveImageView.bottomAnchor, constant: -90),
            mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -60),
            mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor, multiplier: 1.2)
        ])
    }
    
    private func layoutStackView() {
        stackView.addArrangedSubview(appleIDSignInButton)
        stackView.addArrangedSubview(googleSignInButton)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: Constants.General.defaultSpacing),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
//    private func layoutBottomWaveImageView() {
//        addSubview(bottomWaveImageView)
//
//        NSLayoutConstraint.activate([
//            bottomWaveImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            bottomWaveImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
//            bottomWaveImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            bottomWaveImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.2)
//        ])
//    }
    
    private func layoutSignInWithEmailLabel(){
        addSubview(signInWithEmailLabel)
        
        NSLayoutConstraint.activate([
            signInWithEmailLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            signInWithEmailLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func layoutAlreayHaveAccountLabel() {
        addSubview(alreayHaveAccountLabel)
        
        NSLayoutConstraint.activate([
            alreayHaveAccountLabel.topAnchor.constraint(equalTo: signInWithEmailLabel.bottomAnchor, constant: 30),
            alreayHaveAccountLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func layoutBottomView() {
        addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: googleSignInButton.bottomAnchor, constant: Constants.General.defaultSpacing),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.General.defaultSpacing),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.General.defaultSpacing),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.General.defaultSpacing)
        ])
    }
    
}
