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
    
    var registrationViewModel: UserRegistration?
    var passwordRules: ValidationRuleSet<String> = ValidationRuleSet<String>()
    var emailRules: ValidationRuleSet<String> = ValidationRuleSet<String>()
    
    lazy var plusPhotoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.brown
//        button.backgroundColor = .clear
//        button.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        return button
    }()
    
    lazy var firstNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "First Name"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        //        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var lastNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Last Name"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
        //        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleEmailTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
//        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        
//        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
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
    
    func handleSignup() {
        registrationViewModel?.createUser()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registrationViewModel = RegistrationViewModel()
        setupValidationRules()
        setupPhotoButton()
        setupInputFields()
        // Do any additional setup after loading the view.
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
        
        emailTextField.validationRules = emailRules
        passwordTextField.validationRules = passwordRules
    }
    
    // - MARK: textfield selector methods
    
    func handleEmailTextInputChange() {
        emailTextField.validationHandler = { result in
            switch result  {
            case .valid:
                print("VAlid!")
            case . invalid(let failureErrors):
                let messages = failureErrors.map( { $0 } )
                print("invalid", messages)
            }
        }
        emailTextField.validateOnInputChange(enabled: true)
    }
    
    func handlePasswordTextInputChange() {
        passwordTextField.validationHandler { result in
            switch result {
            case .valid:
                print("VAlid!")
            case . invalid(let failureErrors):
                let messages = failureErrors.map( { $0 } )
                print("invalid", messages)
            }
        }
        passwordTextField.validateOnInputChange(enabled: true)
    }
    

}
