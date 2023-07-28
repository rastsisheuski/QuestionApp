//
//  MainViewController.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit
import Combine

class MainViewController: NiblessViewController {
    let viewModel: MainViewModel
    
    private let launchViewControllerFactory: () -> LaunchViewController
    private let onboardingViewControllerFactory: () -> OnboardingViewController
    private let singInViewControllerFactory: () -> SignInViewController
    private let registrationViewControllerFactory: () -> RegistrationViewController
    private let mainTabBarControllerFactory: () -> UITabBarController
    
    private let currentNavigationController = UINavigationController()
    private var cancellable = Set<AnyCancellable>()
    
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
        viewModel.checkIsOnboardingWasShowen()
    }
    
    private func bindViewModel() {
        viewModel.isDisplayingOnboarding.receive(on: DispatchQueue.main).sink { [weak self] needDisplayOnboarding in
            if needDisplayOnboarding {
                self?.presentOnboardingViewController()
            } else {
                self?.presentSignInViewController()
            }
        }.store(in: &cancellable)
        
        viewModel.isDisplayingSignIn.receive(on: DispatchQueue.main).sink { [weak self]  needDisplaySignIn in
            if needDisplaySignIn {
                self?.presentSignInViewController()
            } else {
                // сделать скрытие sign in
            }
        }.store(in: &cancellable)
        
        viewModel.isDisplayingRegistration.receive(on: DispatchQueue.main).sink { [weak self] needDisplayRegistration in
            if needDisplayRegistration {
                self?.presentRegistrationViewController()
            } else {
                self?.hideRegistrationViewController()
            }
        }.store(in: &cancellable)
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
    
    private func presentSignInViewController() {
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
    
    private func hideRegistrationViewController() {
        currentNavigationController.popViewController(animated: true)
    }
}
