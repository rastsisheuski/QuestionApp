//
//  MainViewController.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit
import Combine

class MainViewController: NiblessViewController {
    
    // MARK: -
    // MARK: - Public Properties
    
    let viewModel: MainViewModel
    
    // MARK: -
    // MARK: - Private Properties
    
    private let launchViewControllerFactory: () -> LaunchViewController
    private let onboardingViewControllerFactory: () -> OnboardingViewController
    private let singInViewControllerFactory: () -> SignInViewController
    private let registrationViewControllerFactory: () -> RegistrationViewController
    private let mainTabBarControllerFactory: () -> UITabBarController
    
    private let currentNavigationController = UINavigationController()
    private let splashWindow: UIWindow
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: -
    // MARK: - Lifecycle
    
    init(viewModel: MainViewModel,
         launchViewControllerFactory: @escaping () -> LaunchViewController,
         onboardingViewControllerFactory: @escaping () -> OnboardingViewController,
         singInViewControllerFactory: @escaping () -> SignInViewController,
         registrationViewControllerFactory: @escaping () -> RegistrationViewController,
         mainTabBarControllerFactory: @escaping () -> UITabBarController,
         splashWindow: UIWindow)
    {
        self.viewModel = viewModel
        self.launchViewControllerFactory = launchViewControllerFactory
        self.onboardingViewControllerFactory = onboardingViewControllerFactory
        self.singInViewControllerFactory = singInViewControllerFactory
        self.registrationViewControllerFactory = registrationViewControllerFactory
        self.mainTabBarControllerFactory = mainTabBarControllerFactory
        self.splashWindow = splashWindow
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.showLaunch()
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func bindLaunchViewController() {
        guard let launchVC = splashWindow.rootViewController as? LaunchViewController else { return }
        
        if launchVC.isAnimationWasShown {
            launchVC.startDismissAnimation()
            splashWindow.resignKey()
            splashWindow.isHidden = true
        } else {
            launchVC.animationCompletion = { [launchVC] in
                launchVC.startDismissAnimation()
            }
        }
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
        
        viewModel.isDisplayingLaunch.receive(on: DispatchQueue.main).sink { [weak self] needDisplayLaunch in
            if needDisplayLaunch {
                self?.presentLaunchViewController()
            } else {
                self?.bindLaunchViewController()
            }
        }.store(in: &cancellable)
    }
    
    private func presentLaunchViewController() {
        let launchVC = launchViewControllerFactory()
        splashWindow.rootViewController = launchVC
        splashWindow.isHidden = false
        splashWindow.makeKeyAndVisible()
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
