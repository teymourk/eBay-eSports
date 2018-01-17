//
//  PageViewController.swift
//  LeetLoot
//
//  Created by Will on 12/28/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class PageView: UIViewController,  UIScrollViewDelegate {
    
    var menuBar = { () -> MenuBar in
        let view = MenuBar()
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set navigation bar
        navigationItem.title = "LeetLoot"
        navigationController?.navigationBar.isTranslucent = false;
        
        setupMenuBar()
        setupNavBar()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
    }
    
    private func setupNavBar() {
        let signIn = UIBarButtonItem(title: "Browse game", style: .plain, target: self, action: #selector(onSignIn(sender: )))
        navigationItem.leftBarButtonItem = signIn
    }
    
    @objc
    private func onSignIn(sender: UIBarButtonItem) {
        //signIn.openMenu()
        let layout = UICollectionViewFlowLayout()
        let myPge = Browse_Game(collectionViewLayout: layout)
        navigationController?.pushViewController(myPge, animated: true)
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        NSLayoutConstraint.activate([
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
