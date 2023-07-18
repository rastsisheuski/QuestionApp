//
//  QuestionDependencyContainer.swift.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit

class QuestionDependencyConteiner {
    
    func makeMainViewcontroller() -> MainViewController {
        
        let sharedViewModel = createMainViewModel()
        let sharedAuthManager = createAuthManager()
        let sharedAPIManager = createAPIManager()
        
        let launchViewControllerFactory = {
            self.makeLaunchViewControllerFactory()
        }
        
        let onboardingViewControllerFactory = {
            self.makeOnboardingViewcontrollerFactory(navigationResponer: sharedViewModel)
        }
        
        let signInViewControllerFactory = {
            self.makeSignInViewcontrollerFactory(
                navigationRespnoder: sharedViewModel,
                authManager: sharedAuthManager,
                apiManager: sharedAPIManager
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
    
    private func makeOnboardingViewcontrollerFactory(navigationResponer: MainResponder) -> OnboardingViewController {
        let onboardingViewModel = makeOnboardingViewModel()
        return OnboardingViewController(viewModel: onboardingViewModel, navigationResponer: navigationResponer)
    }
    
    private func makeOnboardingViewModel() -> OnboardingViewModel {
        return OnboardingViewModel()
    }
    
    private func makeSignInViewcontrollerFactory(
        navigationRespnoder: MainResponder,
        authManager: AuthManager,
        apiManager: APIManager
    ) -> SignInViewController {
        let signInViewModel = createSignInViewModel(
            authManager: authManager,
            apiManager: apiManager
        )
        return SignInViewController(
            viewModel: signInViewModel,
            navigationResponer: navigationRespnoder
        )
    }
    
    private func createSignInViewModel(
        authManager: AuthManager,
        apiManager: APIManager
    ) -> SignInViewModel {
        return SignInViewModel(
            authManager: authManager,
            apiManager: apiManager
        )
    }
    
    private func makeRegistrationViewControllerFactory(navigationStepBackResponder: NavigationStepBackResponder) -> RegistrationViewController {
        let registrationViewModel = createRegistrationViewModel()
        return RegistrationViewController(viewModel: registrationViewModel, navigationStepBackResponder: navigationStepBackResponder)
    }
    
    private func createRegistrationViewModel() -> RegistrationViewModel {
        return RegistrationViewModel()
    }
    
    private func makeMainTabBarController() -> UITabBarController {
        QuestionDependencyConteiner().makeMainTabBarController()
    }
    
    private func createMainViewModel() -> MainViewModel {
        return MainViewModel()
    }
    
    private func createAuthManager() -> AuthManager {
        return AuthManager()
    }
    
    private func createAPIManager() -> APIManager {
        return APIManager()
    }
}
