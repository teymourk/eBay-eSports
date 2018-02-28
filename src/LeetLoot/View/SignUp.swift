//
//  SignUp.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 2/21/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

protocol HomePagesDelegate {
    func onScreenButtons(_ sender: UIButton)
}
class SignUp: ParentView {
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
    private let signInLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Register"
        lb.translatesAutoresizingMaskIntoConstraints = false;
        return lb;
    }()
    private lazy var emailContainerView : UIView = {
        
        let emailContainerView = UIView()
        emailContainerView.backgroundColor = .lightGray
        emailContainerView.translatesAutoresizingMaskIntoConstraints=false
        emailContainerView.layer.cornerRadius = 4
        emailContainerView.layer.masksToBounds = true
        return emailContainerView
    }()
    private let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .emailAddress
        textfield.font = UIFont(name:"Helvectica",size:14)
        return textfield;}()

        private lazy var passwordContainerView : UIView = {
            let passwordContainerView = UIView()
            passwordContainerView.backgroundColor = .lightGray
            passwordContainerView.translatesAutoresizingMaskIntoConstraints=false
            passwordContainerView.layer.cornerRadius = 4
            passwordContainerView.layer.masksToBounds = true
            return passwordContainerView
        }()
    private let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .emailAddress
        textfield.isSecureTextEntry = true
        textfield.font = UIFont(name:"Helvectica",size:14)
        return textfield;
    }()
    private lazy var confirmPasswordContainerView : UIView = {
        let passwordContainerView = UIView()
        passwordContainerView.backgroundColor = .lightGray
        passwordContainerView.translatesAutoresizingMaskIntoConstraints=false
        passwordContainerView.layer.cornerRadius = 4
        passwordContainerView.layer.masksToBounds = true
        return passwordContainerView
    }()
    private let confirmPasswordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Confirm Password"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .emailAddress
        textfield.isSecureTextEntry = true
        textfield.font = UIFont(name:"Helvectica",size:14)
        return textfield;
    }()
    private lazy var register: UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = .lightBlue
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont .boldSystemFont(ofSize: 14)
        // button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
        
    }()
    var delegate:RegisterPagesDelegate?
    @objc
    func onScreenButtons(_ sender: UIButton) {
        guard delegate != nil else { return }
        delegate?.onScreenButtons(sender)
    }
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
        NSLayoutConstraint.activate([
            passwordContainerView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 116),
            passwordContainerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 23),
            passwordContainerView.widthAnchor.constraint(equalToConstant: 329),
            passwordContainerView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.leftAnchor.constraint(equalTo: passwordContainerView.leftAnchor, constant: 20),
            passwordTextField.topAnchor.constraint(equalTo: passwordContainerView.topAnchor,constant:15),
            passwordTextField.widthAnchor.constraint(equalToConstant: 64),
            passwordTextField.heightAnchor.constraint(equalToConstant: 17)
            ])
    }
    func setupConfirmPassword(){
        addSubview(confirmPasswordContainerView)
        NSLayoutConstraint.activate([
            confirmPasswordContainerView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 181),
            confirmPasswordContainerView.leftAnchor.constraint(equalTo:leftAnchor, constant: 23),
            confirmPasswordContainerView.widthAnchor.constraint(equalToConstant: 329),
            confirmPasswordContainerView.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        addSubview(confirmPasswordTextField)
        NSLayoutConstraint.activate([
            confirmPasswordTextField.leftAnchor.constraint(equalTo: confirmPasswordContainerView.leftAnchor, constant: 20),
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordContainerView.topAnchor,constant:15),
            confirmPasswordTextField.widthAnchor.constraint(equalToConstant: 118),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 17)
            ])
        
    }
    func setupRegister(){
        addSubview(register)
        //setup constraints
        NSLayoutConstraint.activate([
            register.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 283),
            register.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            register.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 5),
            register.widthAnchor.constraint(equalTo: widthAnchor,constant:-10),
            register.heightAnchor.constraint(equalToConstant: 40)
            ])
    }
    func setupLayoutAttributes() {
        setupEmail();
        setupPassword();
        setupConfirmPassword();
        setupRegister();
}
}
