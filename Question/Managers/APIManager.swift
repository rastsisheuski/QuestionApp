//
//  APIManager.swift
//  Question
//
//  Created by Hleb Rastsisheuski on 18.06.23.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class APIManager {
    
    // MARK: -
    // MARK: - Private Methods
    
    private func configureFirebase() -> Firestore {
        var dataBase: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        dataBase = Firestore.firestore()
        return dataBase
    }
    
    // MARK: -
    // MARK: - Public Methods
    
    func setUserData(currentUser: UserModel, completion: @escaping (Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let dataBase = configureFirebase()
        //        dataBase.collection("Users").document(userUID).collection("UserOrdersHistory").addDocument(data: [
        
        dataBase.collection("Users").document(userUID).setData([
            "name" : currentUser.name,
            "email" : currentUser.email,
            "phone" : currentUser.phoneNumber,
            "basket" : currentUser.currentBasket
        ]){ error in
            completion(error)
        }
    }
}
