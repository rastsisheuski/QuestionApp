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

final class MainViewModel: ObservableObject {
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
    
    // MARK: -
    // MARK: - Public Properties
    
    //    var userID: String?
    
    // MARK: -
    // MARK: - Private Properties
    
    //    @Published private(set) var isDisplayingLaunch = PassthroughSubject<Bool, Never>()
    //    @Published private(set) var isDisplayingSignIn = PassthroughSubject<Bool, Never>()
    //    @Published private(set) var isDisplayingRegistration = PassthroughSubject<Bool, Never>()
    //    @Published private(set) var isDisplayingMainTabBar = PassthroughSubject<Bool, Never>()
    //
    //    private var userProvider: UserProvider
    //
    //    // MARK: -
    //    // MARK: - Lifecycle
    //
    //    init(userProvider: UserProvider) {
    //        self.userProvider = userProvider
    //    }
    //
    //    // MARK: -
    //    // MARK: - Public Methods
    //
    //    func getCurrentUser() {
    //        userProvider.getUser { [weak self] user in
    //            guard let user else {
    //                self?.showSignIn()
    //                return
    //            }
    //            self?.userID = user.userID
    //
    //        }
    //    }
    //
    //}
    //
    //extension MainViewModel: SignInNavigationResponder {
    //    func showSignIn() {
    //        isDisplayingSignIn.send(true)
    //    }
    //}
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

