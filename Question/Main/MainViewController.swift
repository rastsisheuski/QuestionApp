//
//  MainViewController.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit

class MainViewController: NiblessViewController {
    let viewModel: MainViewModel
    
    let launchViewControllerFactory: () -> LaunchViewController
    let onboardingViewControllerFactory: () -> OnboardingViewController
    
    private let currentNavigationController = UINavigationController()
    
    init(viewModel: MainViewModel,
         launchViewControllerFactory: @escaping () -> LaunchViewController,
         onboardingViewControllerFactory: @escaping () -> OnboardingViewController
    ) {
        self.viewModel = viewModel
        self.launchViewControllerFactory = launchViewControllerFactory
        self.onboardingViewControllerFactory = onboardingViewControllerFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func bindViewNodel() {
        viewModel.mainView.bind { [weak self] mainView in
            guard let mainView else { return }
            
            switch mainView {
                case .launch:
                    self?.presentShowLaunchViewController()
                case .onboarding:
                    self?.presentOnboardingViewController()
            }
        }
        viewModel.stepBack.bind { [weak self] _ in
            self?.currentNavigationController.popViewController(animated: true)
        }
    }
    
    private func presentShowLaunchViewController() {
        let launchVC = launchViewControllerFactory()
        addFullScreen(childViewController: currentNavigationController)
        currentNavigationController.viewControllers = [launchVC]
    }
    
    private func presentOnboardingViewController() {
        let onboardingVC = onboardingViewControllerFactory()
        currentNavigationController.pushViewController(onboardingVC,animated: true)
    }
}
