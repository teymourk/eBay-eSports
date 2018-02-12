//
//  Browse_Game.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Browse_Game: UICollectionViewController {
    
    fileprivate var root: [Root]? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    lazy var menuBar = { () -> Menu in
        let view = Menu(isMenu: false)
            view.delegate = self
        return view
    }()
    
    lazy var buyItem = { () -> Buy_Filter in
        let view = Buy_Filter()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupMenuBar()
        setupNavBar()
        requestDataFromAPI()
    }
    
    private func requestDataFromAPI() {
        let root = Root()
            root.searchByKeyWord(Key: "League+of+legends", completion: { self.root = $0 })
    }
    
    private func setupCollectionView() {
        collectionView?.registerCell(Merch_Cell.self)
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

// Mark: - UICollectionViewDelegate
extension Browse_Game {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return root?.first?.itemSummaries?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Merch_Cell = collectionView.reusableCell(indexPath: indexPath)
            cell.item = root?.first?.itemSummaries?[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        buyItem.open(.Buy)
    }
}

// Mark: - UICollectionViewDelegateFlowLayout
extension Browse_Game: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.kWidth * (1/2) - 30
        return CGSize(width: width,
                      height: width * 1.6) //Height Based on Text
    }
    
    //Space Between Header and Collection itself
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let height = menuBar.frame.height + 20
        collectionView.scrollIndicatorInsets.top = height
        return UIEdgeInsets(top: height,
                            left: 20,
                            bottom: 0,
                            right: 20)
    }
}

//Mark: MenuBarDelegate
extension Browse_Game: MenuBarDelegate {
    func onMenuButtons(_ sender: UIButton) {
        buyItem.open(.Filter)
    }
}

