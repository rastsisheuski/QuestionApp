//
//  QuestionDependencyContainer.swift.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit
import Firebase
import FirebaseAuth

class QuestionDependencyContainer {
    
    // MARK: -
    // MARK: - Public Properties
    
    let sharedWindow: UIWindow
    
    // MARK: -
    // MARK: - LifeCycle
    
    init(sharedWindow: UIWindow) {
        self.sharedWindow = sharedWindow
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func makeMainViewController() -> MainViewController {
        
        let sharedViewModel = createMainViewModel()
        let foregroundSplashWindow = createSplashWindow(windowLevel: .alert + 1)
        
        let launchViewControllerFactory = {
            self.makeLaunchViewControllerFactory()
        }
        
        let onboardingViewControllerFactory = {
            self.makeOnboardingViewControllerFactory(navigationResponder: sharedViewModel)
        }
        
        let signInViewControllerFactory = {
            self.makeSignInViewControllerFactory(
                navigationResponder: sharedViewModel,
                registrationNavigationResponder: sharedViewModel
            )
        }
        
        let registrationViewControllerFactory = {
            self.makeRegistrationViewControllerFactory(navigationStepBackResponder: sharedViewModel)
        }
        
        let mainTabBarFactory = {
            self.makeMainTabBarController()
        }
        
        return MainViewController(
            viewModel: sharedViewModel,
            launchViewControllerFactory: launchViewControllerFactory,
            onboardingViewControllerFactory: onboardingViewControllerFactory,
            singInViewControllerFactory: signInViewControllerFactory,
            registrationViewControllerFactory: registrationViewControllerFactory,
            mainTabBarControllerFactory: mainTabBarFactory,
            splashWindow: foregroundSplashWindow
        )
    }
    
    // MARK: -
    // MARK: - Private Methods
    
    private func makeLaunchViewControllerFactory() -> LaunchViewController {
        return LaunchViewController()
    }
    
    private func makeOnboardingViewControllerFactory(navigationResponder: OnboardingNavigationResponder) -> OnboardingViewController {
        return OnboardingViewController(onboardingNavigationResponder: navigationResponder)
    }
    
    private func makeSignInViewControllerFactory(navigationResponder: SignInNavigationResponder,
                                                 registrationNavigationResponder: RegistrationNavigationResponder) -> SignInViewController {
        let signInViewModel = createSignInViewModel(navigationResponder: navigationResponder)
        let viewController = SignInViewController(viewModel: signInViewModel, registrationNavigationResponder: registrationNavigationResponder)
        return viewController
    }
    
    private func createSignInViewModel(navigationResponder: SignInNavigationResponder) -> SignInViewModel {
        let authorizationManager = createAuthorizationManager()
        return SignInViewModel(signInResponder: navigationResponder, authorizationManager: authorizationManager)
    }
    
    private func createAuthorizationManager() -> AuthorizationManager {
        let googleAuthorizationClient = createGoogleAuthorizationClient()
        let auth = Auth.auth()
        let authorizationManager = FirebaseAuthorizationManager(googleAuthorizationClient: googleAuthorizationClient, auth: auth)
        
        return authorizationManager
    }
    
    private func createGoogleAuthorizationClient() -> GoogleAuthorizationClient {
        let clientId = FirebaseApp.app()?.options.clientID ?? ""
        let window = sharedWindow
        let googleClient = QuestionGoogleAuthorizationClient(clientID: clientId, presentationAnchor: window)
        
        return googleClient
    }
    
    private func makeRegistrationViewControllerFactory(navigationStepBackResponder: RegistrationNavigationStepBackResponder) -> RegistrationViewController {
        return RegistrationViewController(navigationStepBackResponder: navigationStepBackResponder)
    }
    
    private func makeMainTabBarController() -> UITabBarController {
//        QuestionDependencyConteiner().makeMainTabBarController()
        return UITabBarController()
    }
    
    private func createMainViewModel() -> MainViewModel {
        return MainViewModel()
    }
    
    private func createSplashWindow(windowLevel: UIWindow.Level) -> UIWindow {
        guard let windowScene = sharedWindow.windowScene else { return UIWindow() }
        let splashWindow = UIWindow(windowScene: windowScene)
        splashWindow.windowLevel = windowLevel
        
        return splashWindow
    }
}
