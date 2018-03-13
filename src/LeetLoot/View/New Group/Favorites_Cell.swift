//
//  Favorites_Cell.swift
//  LeetLoot
//
//  Created by Will on 1/18/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class Favorites_Cell: ParentCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    var favorites: FavoritesCategory?{
        didSet{
            if let imageName = favorites!.imageName{
                gameImage.downloadImages(url: imageName)
            }
            if let label = favorites!.name{
                textLabel.text = label
            }
            //print("name is: ", favorites!.name)
        }
    }
    
    var curGame:String? {
        didSet{
            
        }
    }

    var userFavorites: [String]?{
        didSet{
            print("fav in fav cell is: ", userFavorites)
            
            self.gameImage.isHidden = true
            self.textLabel.isHidden = true
            self.heartView.isHidden = true
            self.carouselCollectionView.isHidden = true
            self.merchButton.isHidden = true
            self.errorText.isHidden = false
            self.errorText.text = "Sign in to view your favorites."
            
            if Auth.auth().currentUser != nil {
                if let f = userFavorites{
                if f.count > 0 {
                    print("user signed in with favorites")
                    //print("fav counts is ", f.count)
                    self.errorText.isHidden = true
                    self.gameImage.isHidden = false
                    self.textLabel.isHidden = false
                    self.heartView.isHidden = false
                    self.carouselCollectionView.isHidden = false
                    self.merchButton.isHidden = false
                    
                }
                else{
                    print("user signed in with no favorites")
                    self.gameImage.isHidden = true
                    self.textLabel.isHidden = true
                    self.heartView.isHidden = true
                    self.carouselCollectionView.isHidden = true
                    self.merchButton.isHidden = true
                    self.errorText.isHidden = false
                    self.errorText.text = "Go to browse to start favoriting games."
                    
                }
                
                }} else {
                print("no user signed in")
                self.gameImage.isHidden = true
                self.textLabel.isHidden = true
                self.heartView.isHidden = true
                self.carouselCollectionView.isHidden = true
                self.merchButton.isHidden = true
                self.errorText.text = "Sign in to view your favorites."
            }
        }
    }
    
    private lazy var merchButton: UIButton = {
        let button = UIButton(title: "See more", imageName: #imageLiteral(resourceName: "Arrow"))
        
        //button.contentHorizontalAlignment = .left
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0)
        
        button.imageView?.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.leftAnchor.constraint(equalTo: button.leftAnchor, constant: 65).isActive = true
        button.imageView?.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -10).isActive = true
        button.imageView?.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0.0).isActive = true
        
        return button;
    }()
    
   
    let carouselCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()

    
    //game logo image top left corner
    let gameImage: customeImage = {
        let iv = customeImage(frame: .zero)
        iv.image = UIImage(named: "")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.downloadImages(url: "https://static-cdn.jtvnw.net/ttv-boxart/Overwatch-285x380.jpg")
        return iv
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Overwatch"
        label.textColor = .black
        label.font = UIFont(name: "Helvetica-Regular", size:15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let errorText: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: "Helvetica-Regular", size:13)
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let heartView: customeImage = {
        let hv = customeImage(frame: .zero)
        hv.contentMode = .scaleAspectFit
        hv.translatesAutoresizingMaskIntoConstraints = false
        hv.tintColor = UIColor.lightBlue
        hv.image = #imageLiteral(resourceName: "Path").withRenderingMode(.alwaysTemplate)
        hv.isUserInteractionEnabled = true
        return hv
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CarouselCollectionView
    }
    
    //sizing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 130)
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
         
                }
            }
             }, withCancel: nil)
         
         }
     
     }
    
    override func setupView() {
        
        addSubview(gameImage)
        addSubview(textLabel)
        addSubview(heartView)
        addSubview(carouselCollectionView)
        addSubview(merchButton)
        addSubview(errorText)
        
        //to generate multiple cells in nested collection view
        carouselCollectionView.dataSource = self
        carouselCollectionView.delegate = self
        
        //register item cell to the collection view
        carouselCollectionView.register(CarouselCollectionView.self, forCellWithReuseIdentifier: cellId)
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(browseItemCell.checkAction))
        gesture.cancelsTouchesInView = false
        heartView.addGestureRecognizer(gesture)
        
        //print("no user signed in")
        
       
        
        
        NSLayoutConstraint.activate([
            gameImage.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            gameImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            gameImage.heightAnchor.constraint(equalToConstant: 40),
            gameImage.widthAnchor.constraint(equalToConstant: 30),
            
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 21),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -197),
            textLabel.leftAnchor.constraint(equalTo: gameImage.rightAnchor, constant: 12),
            textLabel.rightAnchor.constraint(equalTo: centerXAnchor),
            
            heartView.topAnchor.constraint(equalTo: topAnchor, constant: 19),
            heartView.rightAnchor.constraint(equalTo: rightAnchor, constant: -19),
            heartView.heightAnchor.constraint(equalToConstant: 24),
            heartView.widthAnchor.constraint(equalToConstant: 22.2),
            
            carouselCollectionView.topAnchor.constraint(equalTo: gameImage.bottomAnchor, constant: 12),
            carouselCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            carouselCollectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            carouselCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            merchButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            merchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            errorText.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            //errorText.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            errorText.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            errorText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            ])
        backgroundColor = .white
    }
    
    //function to allow for CGRectMake in Swift 4
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
}


