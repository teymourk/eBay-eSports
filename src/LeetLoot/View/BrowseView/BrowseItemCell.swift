//
//  BrowseItemCell.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 3/8/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

protocol BrowseDelegate: class {
    func refreshItems()
}

protocol AlertDelegate: class {
    func sendAlert()
}

class browseItemCell: UICollectionViewCell{
 
    var category: Categories? {
        didSet{
            if let imageName = category?.imageName {
                imageView.downloadImages(url: imageName)
                
                if category?.type == "game"{
                    heartView.isHidden = false
                    //curGame = category?.id
                    //curUser = Auth.auth().currentUser?.uid
                }
                else {heartView.isHidden = true}
            }
        }
    }
    
    var curGame: String? {
        didSet{
            if let game = curGame{
                //print ("cur game is: ", game)
                //check if user is null, if not then populate images
                let user = Auth.auth().currentUser?.uid
                //if user is signed in
                if user != nil{
                    //print("we have a user")
                    Database.database().reference().child("users").child(user!).child("favorites").observeSingleEvent(of: .value, with: {(snapshot) in
                     
                        if let items = snapshot.value as? [String:Bool]{
                            //print(items)
                            if let check = items[self.curGame!]
                            {
                                if check == true {
                                    self.heartView.tintColor = UIColor.lightBlue
                                }
                                else if check == false{
                                    self.heartView.tintColor = UIColor.coolGrey
                                }
                                
                            }
                        }
                    }, withCancel: nil)
                    
                }
                
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Auth.auth().addStateDidChangeListener { auth, user in

            self.delegate?.refreshItems()
            
            
        }
        setupViews()
    }

    
    let imageView: customeImage = {
        let iv = customeImage(frame: .zero)
        iv.image = UIImage(named: "")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let heartView: customeImage = {
        let hv = customeImage(frame: .zero)
        hv.contentMode = .scaleAspectFit
        hv.translatesAutoresizingMaskIntoConstraints = false
        hv.tintColor = UIColor.softGrey
        hv.image = #imageLiteral(resourceName: "Path").withRenderingMode(.alwaysTemplate)
        hv.isUserInteractionEnabled = true
        return hv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func checkAction(sender : UITapGestureRecognizer) {
        print("Add this game to favorites")
        let ref = Database.database().reference()
        let user = Auth.auth().currentUser?.uid
        if user != nil{
            
            Database.database().reference().child("users").child(user!).child("favorites").observeSingleEvent(of: .value, with: {(snapshot) in
                
                if let items = snapshot.value as? [String:Bool]{
                    if let check = items[self.curGame!]
                    {
                        let userRef = ref.child("users").child(user!).child("favorites")
                        print("check is: ", check, " opposite is: ", !check)
                        userRef.updateChildValues([self.curGame! : !check])
                        //refresh page
                    
                        self.delegate?.refreshItems()
                        
                    }
                }
            }, withCancel: nil)
       
        }
        else{
            self.alert?.sendAlert()
            
        }
    }
    
    func setupViews(){
        
        addSubview(imageView)
        
        addSubview(heartView)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(browseItemCell.checkAction))
        gesture.cancelsTouchesInView = false
        heartView.addGestureRecognizer(gesture)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            
            heartView.topAnchor.constraint(equalTo: imageView.topAnchor),
            heartView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -103),
            heartView.leftAnchor.constraint(equalTo: leftAnchor, constant: 101),
            heartView.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            
            ])
        
        
        backgroundColor = .clear
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.softGrey.cgColor
        
        
        
        
    }
    
    //function to allow for CGRectMake in Swift 4
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    weak var delegate:BrowseDelegate?
    
    @objc func displayItems() {
        if let del = self.delegate {
            del.refreshItems()
        }
    }

    
    weak var alert:AlertDelegate?
    
    @objc func displayAlert() {
        if let del = self.alert {
            del.sendAlert()
        }
    }

    
}

