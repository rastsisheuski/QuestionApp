//
//  LaunchViewController.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit

final class LaunchViewController: NiblessViewController {
    
    var isAnimationWasShown: Bool = false
    var animationCompletion: (() -> Void)?
    
    // MARK: -
    // MARK: - Private Properties
    
    private var contentView: LaunchViewControllerView {
        view as! LaunchViewControllerView
    }
    
    // MARK: -
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        
        view = LaunchViewControllerView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        contentView.animateLogoTitleAppearance()
        
        let delay: TimeInterval = 2
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.contentView.showFullLogo()
        }
    }
    
    func startDismissAnimation() {
        print("Dismiss")
    }
}

extension LaunchViewController: LaunchViewControllerViewDelegate {
    func animationWasCompleted() {
        isAnimationWasShown = true
        animationCompletion?()
    }
}
