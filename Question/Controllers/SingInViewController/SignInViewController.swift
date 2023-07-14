//
//  SignInViewController.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

class SignInViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Private Properties
    
    private var contentView: SignInViewControllerView {
        view as! SignInViewControllerView
    }
    
    // MARK: -
    // MARK: - Public Properties
    
    let viewModel: SignInViewModel
    let navigationResponer: MainResponder
    
    // MARK: -
    // MARK: - LifeCycle
    
    init(viewModel: SignInViewModel, navigationResponer: MainResponder) {
        self.viewModel = viewModel
        self.navigationResponer = navigationResponer
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        
        view = SignInViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupTargets()
        bindViewModel()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func bindViewModel() {
        viewModel.signInResponce.bind { [weak self] error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            self?.navigationResponer.showMainTabBar()
        }
    }
    
    private func setupTargets() {
        contentView.bottomView.enterButton.addTarget(self, action: #selector(wasEnterButtonTapped), for: .touchUpInside)
        contentView.bottomView.registrationButton.addTarget(self, action: #selector(registrationButtonWasPressed), for: .touchUpInside)
    }
    
    private func createLoginUser() -> LoginUserModel? {
        let emailField = contentView.bottomView.emailView.textField
        let passwordField = contentView.bottomView.passwordView.textField
        
        guard let email = emailField.text, emailField.isValid,
              let password = passwordField.text, passwordField.isValid else { return nil }
        
        let loginUser = LoginUserModel(email: email, password: password)
        return loginUser
    }
}

// MARK: -
// MARK: - Extension LoginViewController + @Objc Methods

extension SignInViewController {
    @objc private func wasEnterButtonTapped() {
        contentView.bottomView.checkValidateState()
        guard let loginUser = createLoginUser() else { return }
        viewModel.signIn(loginUser: loginUser)
    }
    
    @objc private func registrationButtonWasPressed() {
        navigationResponer.showRegistration()
    }
}
