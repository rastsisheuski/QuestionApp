//
//  QuestionDependencyContainer.swift.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit
import Firebase
import FirebaseAuth

class QuestionDependencyConteiner {
    
    let sharedWindow: UIWindow
    
    init(sharedWindow: UIWindow) {
        self.sharedWindow = sharedWindow
    }
    
    func makeMainViewcontroller() -> MainViewController {
        
        let sharedViewModel = createMainViewModel()
        
        let launchViewControllerFactory = {
            self.makeLaunchViewControllerFactory()
        }
        
        let onboardingViewControllerFactory = {
            self.makeOnboardingViewControllerFactory(navigationResponder: sharedViewModel)
        }
        
        let signInViewControllerFactory = {
            self.makeSignInViewcontrollerFactory(
                navigationRespnoder: sharedViewModel,
                registrationNavigationRsponder: sharedViewModel
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
            mainTabBarControllerFactory: mainTabBarFactory
        )
    }
    
    private func makeLaunchViewControllerFactory() -> LaunchViewController {
        return LaunchViewController()
    }
    
    private func makeOnboardingViewControllerFactory(navigationResponder: OnboardingNavigationResponder) -> OnboardingViewController {
        let onboardingViewModel = makeOnboardingViewModel()
        return OnboardingViewController(viewModel: onboardingViewModel, onboardingNavigationResponder: navigationResponder)
    }
    
    private func makeOnboardingViewModel() -> OnboardingViewModel {
        return OnboardingViewModel()
    }
    
    private func makeSignInViewcontrollerFactory(navigationRespnoder: SignInNavigationResponder,
                                                 registrationNavigationRsponder: RegistrationNavigationResponder) -> SignInViewController {
        let signInViewModel = createSignInViewModel(navigationResponder: navigationRespnoder)
        let viewController = SignInViewController(viewModel: signInViewModel, registrationNavigationResponder: registrationNavigationRsponder)
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
        let registrationViewModel = createRegistrationViewModel()
        return RegistrationViewController(viewModel: registrationViewModel, navigationStepBackResponder: navigationStepBackResponder)
    }
    
    private func createRegistrationViewModel() -> RegistrationViewModel {
        return RegistrationViewModel()
    }
    
    private func makeMainTabBarController() -> UITabBarController {
//        QuestionDependencyConteiner().makeMainTabBarController()
        return UITabBarController()
    }
    
    private func createMainViewModel() -> MainViewModel {
        return MainViewModel()
    }
}
