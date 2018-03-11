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
}

class SignIn: ParentView, UITextFieldDelegate {
    private let ForgotLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Password Reset email sent"
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let EmLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Please enter a valid email and password."
        lb.textColor = .red
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

    private let eliteLootLogo = { () -> UIImageView in
        let image = UIImageView(image: #imageLiteral(resourceName: "EliteLootLogo"))
            image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var back = { () -> UIButton in
        let button = UIButton(imageName: #imageLiteral(resourceName: "Back"))
            button.addTarget(self, action: #selector(onScreenButtons(_ :)), for: .touchUpInside)
            button.isHidden = true
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
    
    lazy var stack = { () -> UIStackView in
        let stack = UIStackView(arrangedSubviews: [forgot,signin])
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stackView.setCustomSpacing(15.0, after: forgot)
        stackView.setCustomSpacing(15.0, after: signin)
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
    
    private let signInLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Sign in"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont(name: "Helvectica",size:14)
        textfield.keyboardType = .emailAddress
        textfield.backgroundColor = .customGray
        textfield.layer.cornerRadius = 4
        textfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textfield.frame.height))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        
        textfield.becomeFirstResponder()
        
        return textfield
    }()
    
    private let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont(name: "Helvectica",size:14)
        textfield.keyboardType = .emailAddress
        textfield.backgroundColor = .customGray
        textfield.layer.cornerRadius = 4
        textfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textfield.frame.height))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        
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
        button.addTarget(self, action: #selector(signinAction), for: .touchUpInside)
        return button
        
    }()
    
    private lazy var forgot: UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = UIColor.lightBlue
        button.setTitle("FORGOT?", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.addTarget(self, action: #selector(forgotAction), for: .touchUpInside)
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
        transform = CGAffineTransform(scaleX: 1, y: 1)
        setupStackView()
        setupStack()
        setupLayoutAttributes()
        SignInLabel()
    }
    
    func setupStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupStack() {
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -77),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        setupSignin()
        setupForgot()
    }
    
    func SignInLabel() {
        addSubview(signInLabel)
        NSLayoutConstraint.activate([
            //setup constraints
            signInLabel.topAnchor.constraint(equalTo: topAnchor, constant: 63),
            signInLabel.leftAnchor.constraint(equalTo:leftAnchor, constant: 15)
            
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

    //Email container
    func setupEmail(){
        addSubview(emailTextField)
        NSLayoutConstraint.activate([
            //setup constraints
            emailTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 51),
            emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant:15),
            emailTextField.widthAnchor.constraint(equalTo:widthAnchor,constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupPassword(){
        addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 116),
            passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            passwordTextField.widthAnchor.constraint(equalTo:widthAnchor,constant:-30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func setupSignin() {
        addSubview(signin)
        NSLayoutConstraint.activate([
            signin.topAnchor.constraint(equalTo: topAnchor, constant: 228),
            signin.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            signin.leadingAnchor.constraint(equalTo:forgot.trailingAnchor,constant:15),
            signin.widthAnchor.constraint(equalToConstant:157)
            
            ])
    }
    
    //Forgot
    func setupForgot() {
        addSubview(forgot)
        NSLayoutConstraint.activate([
            forgot.topAnchor.constraint(equalTo: topAnchor, constant: 228),
            forgot.leftAnchor.constraint(equalTo:leftAnchor, constant: 15),
            forgot.widthAnchor.constraint(equalTo:signin.widthAnchor)
            ])
    }
    
    func forgotLabel(){
        addSubview(ForgotLabel)
        NSLayoutConstraint.activate([
            //setup constraints
            ForgotLabel.topAnchor.constraint(equalTo: topAnchor, constant: 285),
            ForgotLabel.centerXAnchor.constraint(equalTo:centerXAnchor)
            ])
        ForgotLabel.isHidden = true;
        
    }
    
    func EmailLabel() {
        addSubview(EmLabel)
        NSLayoutConstraint.activate([
            //setup constraints
            EmLabel.topAnchor.constraint(equalTo: topAnchor, constant: 285),
            EmLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        EmLabel.isHidden = true
    }
        
    //Put layout here
    func setupLayoutAttributes() {
        setupRegister()
        setupPassword()
        setupEmail()
        forgotLabel()
        EmailLabel()

    }
    
    //sigin helper
    func setsigninbuttonenabled(enabled:Bool){
        if(enabled)
        {
            signin.isEnabled = true
        }
        else{
            signin.isEnabled = false
        }
        
    }
    
    //forgot helper
    func setforgotbuttonenabled(enabled:Bool){
        if (enabled) {
            forgot.isEnabled = true
        } else{
            forgot.isEnabled = false
        }
        
    }
    
    //signin
    @objc
    func signinAction(){
        guard let em = emailTextField.text else {
            return }
        guard let pass = passwordTextField.text else {
            return }
       
        Auth.auth().signIn(withEmail: em, password: pass) { user,error in
            if let error = error {
                self.EmLabel.isHidden = false
                self.setsigninbuttonenabled(enabled:true)
                print(error.localizedDescription)
            }
            else if let user = user {
                print("user id:" + user.uid)
                self.EmLabel.isHidden = true
                self.setsigninbuttonenabled(enabled:false)
            }
        
    }
        
    }
    //forgot
    @objc
    func forgotAction(){
        guard let em = emailTextField.text else { return }
        Auth.auth().sendPasswordReset(withEmail: em) {(error) in
            if(error == nil)
            {
                self.ForgotLabel.isHidden = false
                print("Password reset successfully.")
            }
            else{
                print(error!.localizedDescription)
            }
        }
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
    


