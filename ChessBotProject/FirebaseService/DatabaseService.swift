//
//  DatabaseService.swift
//  ChessBotProject
//
//  Created by Edward O'Neill on 4/8/20.
//  Copyright © 2020 Edward O'Neill. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
    
    static let usersCollection = "users"
    static var shared = DatabaseService()
    
    private let db = Firestore.firestore()
    
    public func createDatabaseUser(authDataResult: AuthDataResult,
                                   accountType: String,
                                   completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let email = authDataResult.user.email else { return }
        
        db.collection(DatabaseService.usersCollection)
            .document(authDataResult.user.uid)
            .setData(["email" : email,
                      "createdDate": Timestamp(date: Date()),
                      "userId": authDataResult.user.uid]) { (error) in
                        
                        if let error = error {
                            completion(.failure(error))
                        } else {
                            completion(.success(true))
                        }
        }
    }
    
    func updateDatabaseUser(accountType: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.usersCollection).document(user.uid).updateData(["account_type" : accountType]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func signoutButtonPressed() {
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController(storyBoardName: "LoginView", viewControllerId: "LoginViewController")
        } catch {
            fatalError("Couldn't sign out")
        }
    }
}

