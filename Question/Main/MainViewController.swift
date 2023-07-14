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
    let singInViewControllerFactory: () -> SignInViewController
    let registrationViewControllerFactory: () -> RegistrationViewController
    let mainTabBarControllerFactory: () -> UITabBarController
    
    private let currentNavigationController = UINavigationController()
    
    init(viewModel: MainViewModel,
         launchViewControllerFactory: @escaping () -> LaunchViewController,
         onboardingViewControllerFactory: @escaping () -> OnboardingViewController,
         singInViewControllerFactory: @escaping () -> SignInViewController,
         registrationViewControllerFactory: @escaping () -> RegistrationViewController,
         mainTabBarControllerFactory: @escaping () -> UITabBarController)
    {
        self.viewModel = viewModel
        self.launchViewControllerFactory = launchViewControllerFactory
        self.onboardingViewControllerFactory = onboardingViewControllerFactory
        self.singInViewControllerFactory = singInViewControllerFactory
        self.registrationViewControllerFactory = registrationViewControllerFactory
        self.mainTabBarControllerFactory = mainTabBarControllerFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.checkAuthorization()
    }
    
    private func bindViewModel() {
        viewModel.mainView.bind { [weak self] mainView in
            guard let mainView,
                  let self else { return }
            
            switch mainView {
                case .launch:
                    self.presentLaunchViewController()
                case .onboarding:
                    self.presentOnboardingViewController()
                case .singIn:
                    self.presentSignInViewcontroller()
                case .registration:
                    self.presentRegistrationViewController()
                case .mainTabBar:
                    self.presentMainTabBarController()
            }
        }
        viewModel.stepBack.bind { [weak self] _ in
            self?.currentNavigationController.popViewController(animated: true)
        }
    }
    
    private func presentLaunchViewController() {
        let launchVC = launchViewControllerFactory()
        addFullScreen(childViewController: currentNavigationController)
        currentNavigationController.viewControllers = [launchVC]
    }
    
    private func presentOnboardingViewController() {
        let onboardingVC = onboardingViewControllerFactory()
        addFullScreen(childViewController: currentNavigationController)
        currentNavigationController.pushViewController(onboardingVC,animated: true)
    }
    
    private func presentSignInViewcontroller() {
        let signInVC = singInViewControllerFactory()
        addFullScreen(childViewController: currentNavigationController)
        currentNavigationController.viewControllers = [signInVC]
    }
    
    private func presentRegistrationViewController() {
        let registrationVC = registrationViewControllerFactory()
        currentNavigationController.pushViewController(registrationVC, animated: true)
    }
    
    private func presentMainTabBarController() {
        remove(childViewController: currentNavigationController)
        let mainTabBar = mainTabBarControllerFactory()
        addFullScreen(childViewController: mainTabBar)
    }
}
