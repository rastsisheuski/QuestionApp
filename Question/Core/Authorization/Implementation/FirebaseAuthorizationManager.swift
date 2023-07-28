//
//  FirebaseAuthorizationManager.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 27.07.23.
//

import Foundation
import FirebaseAuth

protocol FirebaseAuth {
    func requestUserID(with credential: AuthCredential, completion: @escaping (String?, Error?) -> Void)
}

extension Auth: FirebaseAuth {
    func requestUserID(with credential: AuthCredential, completion: @escaping (String?, Error?) -> Void) {
        signIn(with: credential) { authResult, error in
            completion(authResult?.user.uid, error)
        }
    }
}

final class FirebaseAuthorizationManager: AuthorizationManager {
    
    enum Error: Swift.Error {
        case missingUserID
    }
    
    private let googleAuthorizationClient: GoogleAuthorizationClient
    private let auth: FirebaseAuth
    private var completion: ((AuthorizationResult) -> Void)?
    
    init(googleAuthorizationClient: GoogleAuthorizationClient, auth: FirebaseAuth) {
        self.auth = auth
        self.googleAuthorizationClient = googleAuthorizationClient
    }
    
    func requestAuthorization(in type: AuthorizationType, completion: @escaping (AuthorizationResult) -> Void) {
        switch type {
            case .google:
                googleAuthorizationClient.requestAuthorization { [weak self] result in
                    switch result {
                        case .success(let authResult):
                            self?.signInFirebase(with: authResult)
                        case .failure(let error):
                            completion(.failure(error))
                    }
                }
        }
        self.completion = completion
    }
    
    private func signInFirebase(with authorizationResult: GoogleAuthorizationResult) {
        let credentials = GoogleAuthProvider.credential(withIDToken: authorizationResult.idToken, accessToken: authorizationResult.accessToken)
        
        signInInFirebase(with: credentials)
    }
    
    private func signInInFirebase(with credential: AuthCredential) {
        auth.requestUserID(with: credential) { [weak self] (userID, error) in
            if let error = error {
                self?.completion?(.failure(error))
                return
            }
            guard let userID else {
                self?.completion?(.failure(Error.missingUserID))
                return
            }
            self?.completion?(.success(userID))
        }
    }
}
