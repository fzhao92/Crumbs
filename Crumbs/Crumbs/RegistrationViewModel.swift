//
//  RegistrationViewModel.swift
//  Crumbs
//
//  Created by Forrest Zhao on 5/15/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import Foundation
import Validator

class RegistrationViewModel: UserRegistration {
    
    var firstName: String?
    var lastName: String?
    var email: String?
    var userName: String?
    var password: String?
    var passwordRules: ValidationRuleSet<String>
    var emailRules: ValidationRuleSet<String>

    
    init() {
        passwordRules = ValidationRuleSet<String>()
        emailRules = ValidationRuleSet<String>()
    }
    
    
    func setupRules() {
        let lengthRule = ValidationRuleLength(min: 6, max: 50, error: PasswordValidationErrors.invalidLength)
        passwordRules.add(rule: lengthRule)
        
        let emailFormatRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: EmailValidationErrors.invalidFormat)
        emailRules.add(rule: emailFormatRule)
    }
    
    func validatePassword() -> Bool {
        return true
    }
    
    func validateUserName() -> Bool {
        return true
    }
    
    func validateEmail() -> Bool {
        return true
    }
    
    func validateFirstName() -> Bool {
        return true
    }
    
    func validateLastName() -> Bool {
        return true
    }
}
