//
//  RegistrationViewModel.swift
//  Crumbs
//
//  Created by Forrest Zhao on 5/15/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import Foundation
import Validator
import FirebaseAuth

class RegistrationViewModel: UserRegistration {
    
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var userName: String = ""
    var password: String = ""
    
    var firstNameValid = false
    var lastNameValid = false
    var emailValid = false
    var userNameValid = false
    var passwordValid = false

    init() {
        
    }
    
    func createUser() {
        if firstNameValid && lastNameValid && userNameValid && passwordValid {
            let user = User(firstName: firstName, lastName: lastName, userName: userName)
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
}
