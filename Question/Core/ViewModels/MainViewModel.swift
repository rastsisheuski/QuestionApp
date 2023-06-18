//
//  MainViewModel.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 17.06.23.
//

import UIKit

class MainViewModel {
    let mainView: Dynamic<MainView?> = Dynamic(nil)
    let stepBack: Dynamic<Void> = Dynamic(Void())
    let isAuthorized: Dynamic<Bool?> = Dynamic(nil)
    
//    func checkAuthorization() {
//        if Auth.auth().currentUser != nil {
//            self.mainView.value = .mainTabBar
//        } else {
//            self.mainView.value = .login
//        }
//    }
}

extension MainViewModel: MainResponder {
    func showLaunch() {
        mainView.value = .launch
    }
    
    func showOnboarding() {
        mainView.value = .onboarding
    }
}
