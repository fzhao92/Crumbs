//
//  ValidationErrors.swift
//  Crumbs
//
//  Created by Forrest Zhao on 5/15/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import Foundation

enum EmailValidationErrors: String, Error, CustomStringConvertible {
    case invalidFormat = "Format must be XXX@XXXX"
    
    var description: String {
        return self.rawValue
    }
}

enum PasswordValidationErrors: String, Error, CustomStringConvertible {
    case invalidLength = "Must be between 6 and 50 characters"
    
    var description: String {
        return self.rawValue
    }
}
