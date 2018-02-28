//
//  SignIn.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/21/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol RegisterPagesDelegate {
    func onScreenButtons(_ sender: UIButton)
}

class SignIn: ParentView {
    
    private let eliteLootLogo = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "EliteLootLogo"))
            image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var back = { () -> UIButton in
        let button = UIButton(imageName: "Back")
            button.addTarget(self, action: #selector(onScreenButtons(_ :)), for: .touchUpInside)
            button.isHidden = true
            button.tag = 0
        return button
    }()
    
    private lazy var close = { () -> UIButton in
        let button = UIButton(imageName: "Close")
            button.addTarget(self, action: #selector(onScreenButtons(_ :)), for: .touchUpInside)
            button.tag = 1
        return button
    }()
    
    private lazy var stackView = { () -> UIStackView in
        let stack = UIStackView(arrangedSubviews: [back, eliteLootLogo, close])
            stack.distribution = .fillProportionally
            stack.translatesAutoresizingMaskIntoConstraints = false
       return stack
    }()
    
    private let register = { () -> UIButton in
        let button = UIButton(title: "Register")
            button.setTitleColor(.lightBlue, for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
            button.addTarget(self, action: #selector(onScreenButtons(_ :)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = 2
        return button
    }()
    private let signInLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Sign in"
        lb.translatesAutoresizingMaskIntoConstraints = false;
        return lb;
    }()
    private let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont(name:"Helvectica",size:14)
        textfield.keyboardType = .emailAddress
        return textfield;
    }()
    private lazy var passwordContainerView : UIView = {
        let passwordContainerView = UIView()
        passwordContainerView.backgroundColor = UIColor.lightGray
        passwordContainerView.translatesAutoresizingMaskIntoConstraints=false
        passwordContainerView.layer.cornerRadius = 4
        passwordContainerView.layer.masksToBounds = true
        return passwordContainerView
    }()
    private let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont(name:"Helvectica",size:14)
        textfield.keyboardType = .emailAddress
        textfield.isSecureTextEntry = true
        return textfield
    }()
    private lazy var emailContainerView: UIView = {
        let emailContainerView = UIView()
        emailContainerView.backgroundColor = UIColor.lightGray
        emailContainerView.translatesAutoresizingMaskIntoConstraints=false
        emailContainerView.layer.cornerRadius = 4
        emailContainerView.layer.masksToBounds = true
        return emailContainerView
        
    }()
    private lazy var signin: UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = UIColor.lightBlue
        button.setTitle("Sign in", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont .boldSystemFont(ofSize: 16)
        return button
        
    }()
    private lazy var forgot: UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = UIColor.lightBlue
        button.setTitle("Forgot?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont .boldSystemFont(ofSize: 16)
        return button
    }()



    
    var delegate:RegisterPagesDelegate?
    
    @objc
    func onScreenButtons(_ sender: UIButton) {
        guard delegate != nil else { return }
        delegate?.onScreenButtons(sender)
    }
    
    //Dont Touch
    override func setupView() {
        
        backgroundColor = .white
        transform = CGAffineTransform(scaleX: 1, y: 1)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        addSubview(signInLabel)
        NSLayoutConstraint.activate([
            //setup constraints
            signInLabel.topAnchor.constraint(equalTo: topAnchor, constant: 63),
            signInLabel.leftAnchor.constraint(equalTo:leftAnchor, constant: 23)
            
            ])
        setupLayoutAttributes()

    }
    
    //Register
    func setupRegister() {
        addSubview(register)
        NSLayoutConstraint.activate([
            register.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            register.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    //email container
    func setupEmail(){
        addSubview(emailContainerView)
        NSLayoutConstraint.activate([
            //setup constraints
            emailContainerView.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 51),
            emailContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant:23),
            emailContainerView.widthAnchor.constraint(equalToConstant: 329),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.leftAnchor.constraint(equalTo: emailContainerView.leftAnchor, constant: 20),
            emailTextField.topAnchor.constraint(equalTo: emailContainerView.topAnchor,constant:15),
            emailTextField.widthAnchor.constraint(equalToConstant: 37),
            emailTextField.heightAnchor.constraint(equalToConstant: 17)
            ])
    }
    func setupPassword(){
        addSubview(passwordContainerView)
        NSLayoutConstraint.activate([ passwordContainerView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 116),passwordContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 23), passwordContainerView.widthAnchor.constraint(equalToConstant: 329),            passwordContainerView.heightAnchor.constraint(equalToConstant: 50)
            ])
        addSubview(passwordTextField)
        NSLayoutConstraint.activate([ passwordTextField.leftAnchor.constraint(equalTo: passwordContainerView.leftAnchor, constant: 20), passwordTextField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor,constant:15), passwordTextField.widthAnchor.constraint(equalToConstant: 64), passwordTextField.heightAnchor.constraint(equalToConstant: 17)
            ])
    }

        func setupSignin() {
            addSubview(signin)
            NSLayoutConstraint.activate([           signin.topAnchor.constraint(equalTo: topAnchor, constant: 228), signin.leftAnchor.constraint(equalTo:leftAnchor, constant:195), signin.widthAnchor.constraint(equalToConstant:157),
                                                    //height
                signin.heightAnchor.constraint(equalToConstant: 40)
                ])
        }
        //Forgot
        func setupForgot() {
            addSubview(forgot)
            NSLayoutConstraint.activate([
                
                forgot.topAnchor.constraint(equalTo: topAnchor, constant: 228),  forgot.leftAnchor.constraint(equalTo:leftAnchor, constant: 23),
                forgot.widthAnchor.constraint(equalToConstant: 157),     forgot.heightAnchor.constraint(equalToConstant: 40)  
                ])
        }
        
    //Put layout here
    func setupLayoutAttributes() {
        setupRegister()
        setupPassword()
        setupSignin()
        setupForgot()
        setupEmail()

    }
}

