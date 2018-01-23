//
//  Browse_Game.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Browse_Game: UICollectionViewController {
    
    lazy var menuBar = { () -> Menu in
        let view = Menu(isMenu: false)
        return view
    }()
    
    let buyItem = { () -> BuyItem in
        let view = BuyItem()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupMenuBar()
        setupNavBar()
    }
    
    private func setupCollectionView() {
        collectionView?.register(Merch_Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = .white
        title = "Game Title"
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.topAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 45),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    //Setup navigation bar
    private func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false;
        let likes = UIBarButtonItem(image: UIImage(named: "Path"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = likes
    }
}

