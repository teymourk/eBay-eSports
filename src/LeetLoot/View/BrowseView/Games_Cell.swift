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

class Games_Cell: ParentCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        label.font = UIFont(name: "Helvetica-Regular", size:15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heartView: customeImage = {
        let hv = customeImage(frame: .zero)
        hv.contentMode = .scaleAspectFit
        hv.translatesAutoresizingMaskIntoConstraints = false
        hv.tintColor = UIColor.softGray
        hv.image = #imageLiteral(resourceName: "Path").withRenderingMode(.alwaysTemplate)
        hv.isUserInteractionEnabled = true
        return hv
    }()
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
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
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshBrowseNotification"), object: nil)
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
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(browseItemCell.checkAction))
        gesture.cancelsTouchesInView = false
        heartView.addGestureRecognizer(gesture)

        NSLayoutConstraint.activate([
            gameImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            gameImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            gameImage.heightAnchor.constraint(equalToConstant: 40),
            gameImage.widthAnchor.constraint(equalToConstant: 30),
            
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            textLabel.leftAnchor.constraint(equalTo: gameImage.rightAnchor, constant: 12),
            textLabel.rightAnchor.constraint(equalTo: centerXAnchor),
            
            heartView.topAnchor.constraint(equalTo: topAnchor, constant: 19),
            heartView.rightAnchor.constraint(equalTo: rightAnchor, constant: -19),
            heartView.heightAnchor.constraint(equalToConstant: 24),
            heartView.widthAnchor.constraint(equalToConstant: 22.2),
            
            
            ])
        
        backgroundColor = .white
    }
    
}
