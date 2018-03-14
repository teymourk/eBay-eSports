//
//  Games_Cell.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 3/12/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

protocol GamesDelegate {
    func updateItems(index: IndexPath)
}

class Games_Cell: ParentCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var delegate: GamesDelegate?

    var curGame:FavoritesCategory? {
        didSet{
            if let imageName = curGame?.imageName {
                gameImage.downloadImages(url: imageName)
            }
            
            if let type = curGame?.name {
                textLabel.text = type
            }
            
            let user = Auth.auth().currentUser?.uid
            //if user is signed in
            if user != nil{
                Database.database().reference().child("users").child(user!).child("favorites").observeSingleEvent(of: .value, with: {(snapshot) in
                    if let items = snapshot.value as? [String:Bool]{
                        if let check = items[self.curGame!.id!]
                        {
                            if check == true {
                                self.heartView.tintColor = UIColor.lightBlue
                            }
                            else if check == false{
                                self.heartView.tintColor = UIColor.softGray
                            }
                            
                        }
                    }
                }, withCancel: nil)
                
            }
        }
    }
    
    var game:String?{
        didSet{
            
        }
    }
    
    var indexPath: IndexPath? {
        didSet{
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Auth.auth().addStateDidChangeListener { auth, user in
            
            let user = Auth.auth().currentUser?.uid
            if user == nil{
                self.heartView.tintColor = UIColor.softGray
            }
        
        }
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //game logo image top left corner
    let gameImage: customeImage = {
        let iv = customeImage(frame: .zero)
        iv.image = UIImage(named: "")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.downloadImages(url: "")
        return iv
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var heartView: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Path").withRenderingMode(.alwaysTemplate), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.tintColor = UIColor.softGray
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        return button
    }()
    
    @objc func checkAction() {
        print("Add this game to favorites")
        let ref = Database.database().reference()
        let user = Auth.auth().currentUser?.uid
        if user != nil{
        
            Database.database().reference().child("users").child(user!).child("favorites").observeSingleEvent(of: .value, with: {(snapshot) in
                
                if let items = snapshot.value as? [String:Bool]{
                    if let check = items[self.game!]
                    {
                        let userRef = ref.child("users").child(user!).child("favorites")
                        print("check is: ", check, " opposite is: ", !check)
                        userRef.updateChildValues([self.game! : !check])
                        self.delegate?.updateItems(index: self.indexPath!)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshHomeNotification"), object: nil)

                        
                    }
                }
            }, withCancel: nil)
            
        }
        else{

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendAlertBrowse"), object: nil)
            
        }
        
    }
    
    override func setupView() {
        addSubview(gameImage)
        addSubview(textLabel)
        addSubview(heartView)

        NSLayoutConstraint.activate([
            gameImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            gameImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            gameImage.heightAnchor.constraint(equalToConstant: 40),
            gameImage.widthAnchor.constraint(equalToConstant: 30),
            
            heartView.topAnchor.constraint(equalTo: topAnchor, constant: 19),
            heartView.rightAnchor.constraint(equalTo: rightAnchor, constant: -19),
            heartView.heightAnchor.constraint(equalToConstant: 24),
            heartView.widthAnchor.constraint(equalToConstant: 22.2),
            
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            textLabel.leftAnchor.constraint(equalTo: gameImage.rightAnchor, constant: 12),
            textLabel.rightAnchor.constraint(equalTo: heartView.leftAnchor),            
            
            ])
        
        backgroundColor = .white
    }
    
}
