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
        setupGesture()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(respondToGesture))
        contentView.signInWithEmailLabel.addGestureRecognizer(gesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(respondToPanGesture))
        contentView.alreayHaveAccountLabel.addGestureRecognizer(tapGesture)
    }
}

extension SignInViewController {
    @objc func respondToPanGesture() {
        contentView.signInWithEmailLabel.isHidden = true
        contentView.alreayHaveAccountLabel.isHidden = true
        contentView.bottomView.alpha = 0.0
        
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.contentView.bottomView.isHidden = false
            self?.contentView.bottomView.alpha = 1.0
            self?.contentView.bottomView.layoutIfNeeded()
        }
    }
    
    @objc func respondToGesture() {
        navigationResponer.showRegistration()
    }
}
