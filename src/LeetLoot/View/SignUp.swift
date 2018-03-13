//
//  SignUp.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/21/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

protocol HomePagesDelegate {
    func onScreenButtons(_ sender: UIButton)
}
class SignUp: SignIn {

    private let confirmPasswordTextField: UITextField = {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        let textfield = UITextField()
            textfield.text = nil
            textfield.isSecureTextEntry = true
            textfield.placeholder = "Confirm Password"
            textfield.font = UIFont(name: "Helvectica",size:14)
            textfield.keyboardType = .emailAddress
            textfield.backgroundColor = .customGray
            textfield.layer.cornerRadius = 4
            textfield.leftView = paddingView
            textfield.leftViewMode = .always
            textfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
            textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var register: UIButton = {
        let button = UIButton(type:.system)
            button.backgroundColor = .lightBlue
            button.setTitle("REGISTER", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 4
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont .boldSystemFont(ofSize: 14)
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.addTarget(self, action: #selector(onRegister(_:)), for: .touchUpInside);
        return button
    }()

    override func setupRegister(){
        addSubview(register)
    
        NSLayoutConstraint.activate([
            register.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            register.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            register.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            register.centerXAnchor.constraint(equalTo:centerXAnchor)
        ])
    }
    
    private func setupConfirmPassword() {
        addSubview(confirmPasswordTextField)
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    override func forgotLabel(){
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 15),
            errorLabel.centerXAnchor.constraint(equalTo:centerXAnchor)
        ])
    }
    
    override func setupLayoutAttributes() {
        back.setImage(#imageLiteral(resourceName: "Back"), for: .normal)
        back.isEnabled = true
        signInLabel.text = "Sign Up"
        setupRegister()
        setupTextFields()
        setupConfirmPassword()
        forgotLabel()
    }
    
    @objc
    func onRegister(_ sender: UIButton) {
        guard   let email = emailTextField.text,
                let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { FBUser,error in
            guard error == nil,
                let user = FBUser else {
                    self.errorLabel.text = self.handleErrorFor(error)
                    self.errorLabel.shake()
                    self.errorLabel.flash()
                    return
            }
            self.createUserWithDatsa(UID: user.uid)
        }
    }
    
    private func createUserWithDatsa(UID:String) {
        let databaseRef = Database.database().reference().child("users/\(UID)"),
        userObject = ["favorites": ["overwatch":false, "lol":false, "dota":false, "sbm":false, "sf":false,
                                    "rl":false, "csgo":false, "hots":false, "sc2":false, "hs":false]] as Dictionary<String, Any>
        databaseRef.setValue(userObject)
        UserDefaults.standard.setValue(UID, forKey: "SignedUser")
        delegate?.signedInSuccessfully()
        emailTextField.text = nil
        passwordTextField.text = nil
        confirmPasswordTextField.text = nil
    }
}
