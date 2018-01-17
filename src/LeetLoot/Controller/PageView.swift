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
    
    var pages: [UIViewController] = {
        let home = Home()
        let browse = Browse()
        return [home, browse]
    }()
    
    var menuOp: MenuBar.MenuOptions!
    
    lazy var pageCarousel = { () -> ScrollView in
        let scrollView = ScrollView()
            scrollView.createScrollableViews(forPages: pages, controller: self)
            scrollView.contentSize.width = view.bounds.size.width * CGFloat(pages.count)
            scrollView.bounces = false
            scrollView.delegate = self
        return scrollView
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
        let width = view.frame.width
        let offsetX = scrollView.contentOffset.x
        menuBar.leftAncharConstraint?.constant = (offsetX / 4) + (width/4)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        menuOp = menuOp == .Home ? .Browse : .Home
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
        menuOp = MenuBar.MenuOptions { menuBar.leftAncharConstraint?.constant = $0 }
        
        view.addSubview(menuBar)
        view.addSubview(pageCarousel)
        
        NSLayoutConstraint.activate([
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 45),
            menuBar.topAnchor.constraint(equalTo: view.topAnchor),
            
            pageCarousel.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            pageCarousel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}
