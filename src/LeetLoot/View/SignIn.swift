//
//  SignIn.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/21/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol RegisterPagesDelegate: class {
    func onScreenButtons(_ sender: UIButton)
    func signedInSuccessfully()
}

class SignIn: ParentView {
    let errorLabel: UILabel = {
        let lb = UILabel()
            lb.text = "Error"
            lb.font = UIFont(name: "Helvetica", size: 14)
            lb.textColor = .red
            lb.textAlignment = .center
            lb.isHidden = true
            lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let signInLabel: UILabel = {
        let lb = UILabel()
            lb.text = "Sign in"
            lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let eliteLootLogo = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "EliteLootLogo"))
            image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var back = { () -> UIButton in
        let button = UIButton(imageName: #imageLiteral(resourceName: "wBack"))
            button.addTarget(self, action: #selector(onScreenButtons(_ :)), for: .touchUpInside)
            button.isEnabled = false
            button.tag = 0
        return button
    }()
    
    private lazy var close = { () -> UIButton in
        let button = UIButton(imageName: #imageLiteral(resourceName: "Close"))
            button.addTarget(self, action: #selector(onScreenButtons(_ :)), for: .touchUpInside)
            button.tag = 1
        return button
    }()
    
    lazy var stackView = { () -> UIStackView in
        let stack = UIStackView(arrangedSubviews: [back, eliteLootLogo, close])
            stack.distribution = .fillProportionally
            stack.translatesAutoresizingMaskIntoConstraints = false
       return stack
    }()
    
    private let register = { () -> UIButton in
        let button = UIButton(title: "REGISTER")
            button.setTitleColor(.lightBlue, for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
            button.addTarget(self, action: #selector(onScreenButtons(_ :)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = 2
        return button
    }()
    
    let emailTextField: UITextField = {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        let textfield = UITextField()
            textfield.text = nil
            textfield.placeholder = "Email"
            textfield.font = UIFont(name: "Helvectica",size:14)
            textfield.keyboardType = .emailAddress
            textfield.backgroundColor = .customGray
            textfield.layer.cornerRadius = 4
            textfield.leftView = paddingView
            textfield.leftViewMode = .always
            textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let passwordTextField: UITextField = {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        let textfield = UITextField()
            textfield.text = nil
            textfield.isSecureTextEntry = true
            textfield.placeholder = "Password"
            textfield.font = UIFont(name: "Helvectica",size:14)
            textfield.keyboardType = .emailAddress
            textfield.backgroundColor = .customGray
            textfield.layer.cornerRadius = 4
            textfield.leftView = paddingView
            textfield.leftViewMode = .always
            textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var signin: UIButton = {
        let button = UIButton(type:.system)
            button.backgroundColor = UIColor.lightBlue
            button.setTitle("SIGN IN", for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 4
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.addTarget(self, action: #selector(onSignIn), for: .touchUpInside)
        return button
        
    }()
    
    private lazy var forgot: UIButton = {
        let button = UIButton(type:.system)
            button.backgroundColor = UIColor.lightBlue
            button.setTitle("FORGOT?", for: .normal)
            button.layer.cornerRadius = 4
            button.setTitleColor(UIColor.white, for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(onForgot), for: .touchUpInside)
        return button
    }()

    weak var delegate:RegisterPagesDelegate?
    
    @objc
    func onScreenButtons(_ sender: UIButton) {
        guard delegate != nil else { return }
        delegate?.onScreenButtons(sender)
    }
    
    //Dont Touch
    override func setupView() {
        backgroundColor = .white
        setupStackView()
        setupLayoutAttributes()
    }
        
    func setupStackView() {
        addSubview(stackView)
        addSubview(signInLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            signInLabel.topAnchor.constraint(equalTo: topAnchor, constant: 63),
            signInLabel.leftAnchor.constraint(equalTo:leftAnchor, constant: 15),
        ])
    }
    
    func setupTextFields() {
        addSubview(emailTextField)
        addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor,constant: 15),
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant:15),
            emailTextField.widthAnchor.constraint(equalTo:widthAnchor,constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setupSignin() {
        addSubview(signin)
        addSubview(forgot)
        NSLayoutConstraint.activate([
            forgot.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 15),
            forgot.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            forgot.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -7.5),
            
            signin.topAnchor.constraint(equalTo: forgot.topAnchor),
            signin.leadingAnchor.constraint(equalTo: forgot.trailingAnchor,constant:15),
            signin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
    func forgotLabel(){
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: forgot.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    //Register
    func setupRegister() {
        addSubview(register)
        NSLayoutConstraint.activate([
            register.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
            register.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }

    //Put layout here
    func setupLayoutAttributes() {
        setupTextFields()
        setupSignin()
        forgotLabel()
        setupRegister()
    }
    
    private func handleErrorUIFor(_ textfield: UITextField) {
        textfield.layer.borderWidth = 0.5
        textfield.layer.borderColor = UIColor.red.cgColor
    }
    
    //signin
    @objc
    func onSignIn(){
        guard   let email = emailTextField.text,
                let pass = passwordTextField.text else { return }
       
        Auth.auth().signIn(withEmail: email, password: pass) { FBUser,error in
            guard error == nil,
                let user = FBUser else {
                self.errorLabel.textColor = .red
                self.errorLabel.text = self.handleErrorFor(error)
                self.errorLabel.shake()
                self.errorLabel.flash()
                return
            }
            print("user id:" + user.user.uid)
            UserDefaults.standard.setValue(user.user.uid, forKey: "SignedUser")
            self.emailTextField.text = nil
            self.passwordTextField.text = nil
            self.delegate?.signedInSuccessfully()
        }
    }
    
    @objc
    func onForgot(){
        guard let email = emailTextField.text else { return }
        Auth.auth().sendPasswordReset(withEmail: email) {(error) in
            guard error == nil else {
                self.errorLabel.textColor = .red
                self.errorLabel.text = self.handleErrorFor(error)
                self.errorLabel.shake()
                self.errorLabel.flash()
                return
            }
            self.errorLabel.textColor = .successGreen
            self.errorLabel.text = "Password reset email sent."
            self.errorLabel.flash()
            print("Password reset successfully.")
        }
    }
    
    func handleErrorFor(_ FBError: Error?) -> String {
        guard   let error = FBError as NSError?,
                let authErrorCode = AuthErrorCode(rawValue: error.code) else { return "" }
        
            switch authErrorCode {
            case .weakPassword:
                return "Invalid password"
            case .wrongPassword:
                return "Invalid password"
            case .userNotFound:
                return "Incorrect email or password"
            case .emailAlreadyInUse:
                return "Email already exists"
            case .invalidEmail:
                return "Invalid email"
            case .missingEmail:
                return "Missing email"
            default: return ""
        }
    }
}






