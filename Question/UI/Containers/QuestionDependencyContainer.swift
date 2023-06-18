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
        let launchViewController = {
            self.makeLaunchViewController()
        }
        let onboardingViewController = {
            self.makeOnboardingViewcontroller()
        }
        
        return MainViewController(
            viewModel: sharedViewModel,
            launchViewControllerFactory: launchViewController,
            onboardingViewControllerFactory: onboardingViewController
        )
    }
    
    private func makeLaunchViewController() -> LaunchViewController {
        return LaunchViewController()
    }
    
    private func makeOnboardingViewcontroller() -> OnboardingViewController {
        return OnboardingViewController()
    }
    
    private func createMainViewModel() -> MainViewModel {
        return MainViewModel()
    }
}
