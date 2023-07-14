//
//  AuthManager.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import Foundation
import FirebaseAuth

class AuthManager {
    private let auth = Auth.auth()
    
    func createUser(user: UserModel, completionBlock: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.createUser(withEmail: user.email, password: user.password) {(result, error) in
            guard let result else {
                let error = NSError(domain: error?.localizedDescription ?? "", code: 401, userInfo: nil)
                completionBlock(.failure(error))
                return
            }
            completionBlock(.success(result))
        }
    }
    
    func signIn(loginUser: LoginUserModel, completionBlock: @escaping (Result<AuthDataResult, Error>) -> Void) {
        auth.signIn(withEmail: loginUser.email, password: loginUser.password) { (result,error) in
            guard let result else {
                let error = NSError(domain: error?.localizedDescription ?? "", code: 401, userInfo: nil)
                completionBlock(.failure(error))
                return
            }
            completionBlock(.success(result))
        }
    }
}
