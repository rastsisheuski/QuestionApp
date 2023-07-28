//
//  LogInViewModel.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import Foundation
import Combine

final class SignInViewModel {
   
    private let signInResponder: SignInNavigationResponder
    private let authorizationManager: AuthorizationManager
    
    init(signInResponder: SignInNavigationResponder, authorizationManager: AuthorizationManager) {
        self.authorizationManager = authorizationManager
        self.signInResponder = signInResponder
    }
    
    func authorizedByGoogle() {
        authorizationManager.requestAuthorization(in: .google) { result in
            switch result {
                case .success(let userID):
                    print(userID)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    private func authorizedUser() {
        signInResponder.hideSignIn()
    }
}

