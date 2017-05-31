//
//  RegistrationViewController.swift
//  Crumbs
//
//  Created by Forrest Zhao on 5/15/17.
//  Copyright © 2017 ForrestApps. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import Validator

class RegistrationViewController: UIViewController {
    
    var passwordRules: ValidationRuleSet<String> = ValidationRuleSet<String>()
    var emailRules: ValidationRuleSet<String> = ValidationRuleSet<String>()
    var generalRules: ValidationRuleSet<String> = ValidationRuleSet<String>()
    
    lazy var plusPhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
//        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleAddPhoto), for: .touchUpInside)
        return button
    }()
    
    lazy var firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "First Name"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.autocorrectionType = .no
        tf.validationHandler = { result in
            switch result  {
            case .valid:
                print("VAlid!")
            case . invalid(let failureErrors):
                let messages = failureErrors.map( { $0 } )
                print("invalid", messages)
            }
        }
        tf.addTarget(self, action: #selector(validateAllTextFields), for: .editingChanged)
        return tf
    }()
    
    lazy var lastNameTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "Last Name"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.spellCheckingType = .no
        tf.validationHandler = { result in
            switch result  {
            case .valid:
                print("VAlid!")
            case . invalid(let failureErrors):
                let messages = failureErrors.map( { $0 } )
                print("invalid", messages)
            }
        }
        tf.addTarget(self, action: #selector(validateAllTextFields), for: .editingChanged)
        return tf
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .no
        tf.validationHandler = { result in
            switch result  {
            case .valid:
                print("VAlid!")
            case . invalid(let failureErrors):
                let messages = failureErrors.map( { $0 } )
                print("invalid", messages)
            }
        }
        tf.addTarget(self, action: #selector(validateAllTextFields), for: .editingChanged)
        return tf
    }()
    
    lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.validationHandler = { result in
            switch result  {
            case .valid:
                print("VAlid!")
            case . invalid(let failureErrors):
                let messages = failureErrors.map( { $0 } )
                print("invalid", messages)
            }
        }
        tf.addTarget(self, action: #selector(validateAllTextFields), for: .editingChanged)
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .no
        tf.validationHandler = { result in
            switch result  {
            case .valid:
                print("VAlid!")
            case . invalid(let failureErrors):
                let messages = failureErrors.map( { $0 } )
                print("invalid", messages)
            }
        }
        tf.addTarget(self, action: #selector(validateAllTextFields), for: .editingChanged)
        return tf
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupValidationRules()
        setupPhotoButton()
        setupInputFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupValidationRules() {
        
        let lengthRule = ValidationRuleLength(min: 6, max: 50, error: PasswordValidationErrors.invalidLength)
        passwordRules.add(rule: lengthRule)
        
        let emailFormatRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: EmailValidationErrors.invalidFormat)
        emailRules.add(rule: emailFormatRule)
        
        let generalLengthRule = ValidationRuleLength(min: 1, max: 50, error: GeneralValidationErrors.invalidLength)
        generalRules.add(rule: generalLengthRule)
    }
    
    fileprivate func setupPhotoButton() {
        view.addSubview(plusPhotoButton)
        plusPhotoButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.width.equalTo(plusPhotoButton.snp.height)
        }
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [firstNameTextField, lastNameTextField, emailTextField,
                                                       usernameTextField, passwordTextField, signUpButton])
        view.addSubview(stackView)
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        firstNameTextField.validationRules = generalRules
        lastNameTextField.validationRules = generalRules
        usernameTextField.validationRules = generalRules
        emailTextField.validationRules = emailRules
        passwordTextField.validationRules = passwordRules
    }
    
    func handleSignup() {
        if let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let username = usernameTextField.text,
            let email = emailTextField.text, let password = passwordTextField.text {
            var newUser = User(firstName: firstName, lastName: lastName, userName: username)
            newUser.profileImage = plusPhotoButton.imageView?.image
            FirebaseClient.createUser(newUser, withEmail: email, andPassword: password)
        }
    }
    
    func handleAddPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func validateAllTextFields() {
        if firstNameTextField.validate().isValid && lastNameTextField.validate().isValid && usernameTextField.validate().isValid
            && emailTextField.validate().isValid && passwordTextField.validate().isValid {
            signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
            signUpButton.isEnabled = true
        } else {
            signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
            signUpButton.isEnabled = false
        }
    }

}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case firstNameTextField:
            firstNameTextField.validateOnInputChange(enabled: true)
        case lastNameTextField:
            lastNameTextField.validateOnInputChange(enabled: true)
        case usernameTextField:
            usernameTextField.validateOnInputChange(enabled: true)
        case emailTextField:
            emailTextField.validateOnInputChange(enabled: true)
        case passwordTextField:
            passwordTextField.validateOnInputChange(enabled: true)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case firstNameTextField:
            firstNameTextField.validateOnInputChange(enabled: false)
        case lastNameTextField:
            lastNameTextField.validateOnInputChange(enabled: false)
        case usernameTextField:
            usernameTextField.validateOnInputChange(enabled: false)
        case emailTextField:
            emailTextField.validateOnInputChange(enabled: false)
        case passwordTextField:
            passwordTextField.validateOnInputChange(enabled: false)
        default:
            break
        }
    }
    
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            plusPhotoButton.setImage(editedImage, for: .normal)
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            plusPhotoButton.setImage(originalImage, for: .normal)
        }
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        dismiss(animated: true, completion: nil)
    }
    
}
