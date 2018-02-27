//
//  Browse_Game.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Browse_Game: UICollectionViewController {
    
    private var m: [Root]? {
        get {
            return root
        }set {
            root?.removeAll()
            root = newValue
        }
    }
    
    fileprivate var root: [Root]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
                self.menuBar.results = self.root?.first?.total
            }
        }
    }
    
    lazy var menuBar = { () -> Menu in
        let view = Menu(isMenu: false)
            view.delegate = self
        return view
    }()
    
    lazy var buyItem = { () -> Buy_Filter in
        let view = Buy_Filter()
            view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupMenuBar()
        setupNavBar()
        requestDataFromAPI()
    }
    
    private var merchRoot = Root(queryKey: "League+of+legends",
                                            filterBy: .All_Items,
                                            sortBy: .Best_Match)

    private func requestDataFromAPI() {
        merchRoot.retrieveDataByName(offset: 0, {
            self.m = $0
        })
    }
    
    private func setupCollectionView() {
        collectionView?.registerCell(Merch_Cell.self)
        collectionView?.backgroundColor = .white
        title = "Game Title"
    }
    
    func setupMenuBar() {
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
            cell.items = root?.first?.itemSummaries?[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard   let root = root?.first,
                let summariesCount = root.itemSummaries?.count else { return }
        if indexPath.item == summariesCount - 10 {
            merchRoot.retrieveDataByName(offset: summariesCount, {
                if let items = $0?.first?.itemSummaries {
                    items.forEach({
                        self.root?[0].itemSummaries?.append($0)
                    })
                }
            })
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        buyItem.open(.Buy)
    }
}

// Mark: - UICollectionViewDelegateFlowLayout
extension Browse_Game: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.kWidth * (1/2) - 28.5
        return CGSize(width: width,
                      height: width * 1.6) //Height Based on Text
    }
    
    //Space Between Header and Collection itself
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let height = menuBar.frame.height + 20
        collectionView.scrollIndicatorInsets.top = height
        return UIEdgeInsets(top: height,
                            left: 19,
                            bottom: 0,
                            right: 19)
    }
}

//Mark: MenuBarDelegate
extension Browse_Game: MenuBarDelegate {
    func onMenuButtons(_ sender: UIButton) {
        buyItem.open(.Filter)
    }
}

//Mark: BuyFilterDelegate
extension Browse_Game: BuyFilterDelegate {
    func updateNewData(for query: Root) {
        self.merchRoot = query
        query.retrieveDataByName(offset: 0, {
            self.m = $0
        })
    }
}


