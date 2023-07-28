//
//  GoogleAuthorizationClient.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 27.07.23.
//

import Foundation

protocol GoogleAuthorizationClient {
    typealias Result = Swift.Result<GoogleAuthorizationResult, Error>
    
    func requestAuthorization(completion: @escaping (Result) -> Void)
}
