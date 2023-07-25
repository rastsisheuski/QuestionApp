//
//  RegistrationViewController.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

class RegistrationViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Private Properties
    
    private var contentView: RegistrationViewControllerView  {
        view as! RegistrationViewControllerView
    }
    
    // MARK: -
    // MARK: - Public Properties
    
    let navigationStepBackResponder: NavigationStepBackResponder
    let viewModel: RegistrationViewModel
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(viewModel: RegistrationViewModel ,navigationStepBackResponder: NavigationStepBackResponder) {
        self.viewModel = viewModel
        self.navigationStepBackResponder = navigationStepBackResponder
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        
        view = RegistrationViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupTargets()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func setupTargets() {
        contentView.backButton.addTarget(self, action: #selector(backButtonWasPressed), for: .touchUpInside)
    }
}

// MARK: -
// MARK: - Extention RegistraionViewController + @objc methods

extension RegistrationViewController {
    @objc private func backButtonWasPressed() {
        navigationStepBackResponder.handleStepBack()
    }
}
