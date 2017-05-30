//
//  FirebaseClient.swift
//  Crumbs
//
//  Created by Forrest Zhao on 5/30/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import Foundation
import FirebaseAuth


class FirebaseClient {
    
    static func createUser(_ user: User, withEmail email: String, andPassword password: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let error = error {
                print("Failed to create user: \(error)")
                return
                // - TODO: error notifications
            }
            
            print("Successfully created user")
        })
    }
    
    
}
