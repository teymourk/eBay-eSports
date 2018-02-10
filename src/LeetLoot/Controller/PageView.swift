//
//  PageViewController.swift
//  LeetLoot
//
//  Created by Will on 12/28/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class PageView: UIViewController {
    
    private lazy var menuBar = { () -> Menu in
        let view = Menu(isMenu: true)
            view.delegate = self
        return view
    }()
    
    private let pages: [UIViewController] = {
        let home = Home(collectionViewLayout: UICollectionViewFlowLayout())
        let browse = Browse(collectionViewLayout: UICollectionViewFlowLayout())
        return [home, browse]
    }()
    
    private var menuOp = Menu.Options.menu
    
    private lazy var pageCarousel = { () -> ScrollView in
        let scrollView = ScrollView()
            scrollView.createScrollableViews(forPages: pages, controller: self)
            scrollView.contentSize.width = view.bounds.size.width * CGFloat(pages.count)
            scrollView.delegate = self
        return scrollView
    }()

    //Custom Title view for the nav bar
    private let titleView = { () -> CustomNavbar in
        let view = CustomNavbar(frame: CGRect(x: 0, y: 0, width: Constants.kWidth * (1/2), height: 50))
            return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuBar()
        setupNavBar()
    }
    
    //Setup navigation bar
    private func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false;
        let profilePic: UIImage = #imageLiteral(resourceName: "ProfileIcon").withRenderingMode(.alwaysOriginal)
        let signIn = UIBarButtonItem(image: profilePic, style: .plain, target: self, action: #selector(onSignIn(sender:)))
        navigationItem.leftBarButtonItem = signIn
        navigationItem.titleView = titleView
    }
    
    @objc
    private func onSignIn(sender: UIBarButtonItem) {
        //Put signin here
        
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addSubview(pageCarousel)
        
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: view.topAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 45),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageCarousel.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            pageCarousel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageCarousel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageCarousel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

//Mark: ScrollViewDelegate
extension PageView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        
        //Prevents scroll bar from extending beyond Home and Browse positions
        if 0...Constants.kWidth  ~= offsetX {
            menuBar.barConstant = (offsetX / menuBar.optionsCount) + (Constants.kWidth / menuBar.optionsCount)
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        menuOp = menuOp == .Home ? .Browse : .Home
    }
}

//Mark: MenuBarDelegate
extension PageView: MenuBarDelegate {
    func onMenuButtons(_ sender: UIButton) {
        menuOp = sender.tag == 0 ? .Home : .Browse
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseInOut ,
                       animations: {
            self.pageCarousel.contentOffset.x = self.menuOp == .Home ? (Constants.kWidth - Constants.kWidth) : Constants.kWidth
            self.view.layoutIfNeeded()
        })
    }
}
