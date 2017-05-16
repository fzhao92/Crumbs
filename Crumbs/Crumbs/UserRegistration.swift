//
//  UserRegistration.swift
//  Crumbs
//
//  Created by Forrest Zhao on 5/15/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import Foundation

protocol UserRegistration {
    
    func validatePassword() -> Bool
    
    func validateUserName() -> Bool
    
    func validateEmail() -> Bool
    
    func validateFirstName() -> Bool
    
    func validateLastName() -> Bool
    
}
