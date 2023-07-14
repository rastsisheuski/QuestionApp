//
//  MainViewModel.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit
import Firebase
import FirebaseAuth

class MainViewModel {
    let mainView: Dynamic<MainView?> = Dynamic(nil)
    let stepBack: Dynamic<Void> = Dynamic(Void())
    let isAuthorized: Dynamic<Bool?> = Dynamic(nil)
    
    func checkAuthorization() {
        if Auth.auth().currentUser != nil {
            self.mainView.value = .mainTabBar
        } else {
            self.mainView.value =  .onboarding
        }
    }
}

extension MainViewModel: MainResponder {
    func showLaunch() {
        mainView.value = .launch
    }
    
    func showOnboarding() {
        mainView.value = .onboarding
    }
    
    func showSignIn() {
        mainView.value = .singIn
    }
    
    func showRegistration() {
        mainView.value = .registration
    }
    
    func showMainTabBar() {
        mainView.value = .mainTabBar
    }
}

extension MainViewModel: NavigationStepBackResponder {
    func handleStepBack() {
        stepBack.value = Void()
    }
}
