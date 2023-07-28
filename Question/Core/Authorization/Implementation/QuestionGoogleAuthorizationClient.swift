//
//  QuestionGoogleAuthorizationClient.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 27.07.23.
//

import GoogleSignIn

final class QuestionGoogleAuthorizationClient: GoogleAuthorizationClient {
    
    enum Error: Swift.Error {
        case invalidGoogleAuthResult
    }
    
    private let clientID: String
    private let presentationAnchor: UIWindow
    
    init(clientID: String, presentationAnchor: UIWindow) {
        self.clientID = clientID
        self.presentationAnchor = presentationAnchor
    }
    
    func requestAuthorization(completion: @escaping (GoogleAuthorizationClient.Result) -> Void) {
        guard let presentationViewController = presentationAnchor.rootViewController else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentationViewController) { result, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                return completion(.failure(Error.invalidGoogleAuthResult))
            }
            completion(.success(GoogleAuthorizationResult(idToken: idToken, accessToken: user.accessToken.tokenString)))
        }
    }
}
