//
//  RegistrationViewController.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: -
    // MARK: - Private Properties
    
    private var contentView: RegistrationViewControllerView  {
        view as! RegistrationViewControllerView
    }
    
    // MARK: -
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        view = RegistrationViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
