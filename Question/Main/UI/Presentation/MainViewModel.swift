//
//  MainViewModel.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit
import Firebase
import FirebaseAuth
import Combine

final class MainViewModel: OnboardingNavigationResponder, SignInNavigationResponder, RegistrationNavigationResponder, RegistrationNavigationStepBackResponder {

    private(set) var isDisplayingOnboarding = PassthroughSubject<Bool, Never>()
    private(set) var isDisplayingSignIn = PassthroughSubject<Bool, Never>()
    private(set) var isDisplayingRegistration = PassthroughSubject<Bool, Never>()
    private(set) var isDisplayingMainTabBar = PassthroughSubject<Bool, Never>()
    
    // MARK: -
    // MARK: - Lifecycle
        
    
    // MARK: -
    // MARK: - Public Methods
    
    func checkIsOnboardingWasShowen() {
        isDisplayingOnboarding.send(true)
    }
    
    func hideOnboarding() {
        isDisplayingOnboarding.send(false)
    }
    
    func hideSignIn() {
        isDisplayingSignIn.send(false)
    }
    
    func showRegistration() {
        isDisplayingRegistration.send(true)
    }
    
    func registrationStepBack() {
        isDisplayingRegistration.send(false)
    }
}


    


