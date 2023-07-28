//
//  AuthorizationManager.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 27.07.23.
//

import Foundation

enum AuthorizationType {
    case google
}

protocol AuthorizationManager {
    typealias AuthorizationResult = Result<String, Error>
    
    func requestAuthorization(in type: AuthorizationType, completion: @escaping (AuthorizationResult) -> Void)
    
}
