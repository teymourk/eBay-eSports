//
//  PageViewController.swift
//  LeetLoot
//
//  Created by Will on 12/28/17.
//  Copyright © 2017 Kiarash Teymoury. All rights reserved.
//

import Foundation
import UIKit

class PageView: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate {
    
    var pages = [UIViewController]()
    
    var menuBar = { () -> MenuBar in
        let view = MenuBar()
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(transitionStyle style: UIPageViewControllerTransitionStyle, navigationOrientation: UIPageViewControllerNavigationOrientation, options: [String : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        let initialPage = 0
        let page1 = Home()
        let page2 = Browse()
        
        // set navigation bar
        navigationItem.title = "LeetLoot"
        navigationController?.navigationBar.isTranslucent = false;
        
        // add the individual viewControllers to the pages array
        self.pages.append(page1)
        self.pages.append(page2)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        setupMenuBar()
        setupScrollViewDelegation()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex == 0 {
                return nil
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            }
        }
        return nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //Moving Horizontal bar goes here.
        print(scrollView.contentOffset.x)
    }
    
    //Set scrollView Delegate
    private func setupScrollViewDelegation() {
        for view in view.subviews {
            if let scrollView = view as? UIScrollView {
                scrollView.delegate = self
            }
        }
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
