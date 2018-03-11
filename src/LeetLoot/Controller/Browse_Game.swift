//
//  Browse_Game.swift
//  LeetLoot
//
//  Created by Kiarash Teymoury on 1/10/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit

class Browse_Game: UICollectionViewController {

    private let loading = { () -> UIImageView in
        let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate var root: [Root]? {
        didSet {
            collectionView?.reloadData()
            menuBar.results = self.root?.first?.total
            loading.stopAnimating()
            print("Reloaded")
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
        merchRoot.retrieveDataByName(offset: 0, loadingImage: loading, { [weak self] in
            self?.root = $0
        })
    }
    
    private func loadMoreData(_ indexPath: IndexPath) {
        guard   let root = root?.first,
                let summariesCount = root.itemSummaries?.count else { return }
        if indexPath.item == summariesCount - 10 {
            merchRoot.retrieveDataByName(offset: summariesCount, loadingImage: loading, { [weak self] in
                if let items = $0?.first?.itemSummaries {
                    self?.root?[0].itemSummaries?.append(contentsOf: items)
                }
            })
        }
    }
    
    private func setupCollectionView() {
        collectionView?.registerCell(Merch_Cell.self)
        collectionView?.backgroundColor = .white
        title = "Game Title"
        setupLoader()
        
        let m = Token()
        m.getToken {
            print($0)
        }
    }
    
    private func setupPaginationLoader() {
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupLoader() {
        view.addSubview(loading)
        NSLayoutConstraint.activate([
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
        return root?.itemsSummary?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: Merch_Cell = collectionView.reusableCell(indexPath: indexPath)
            cell.items.summary = root?.itemsSummary?[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        loadMoreData(indexPath)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard   let itemSummaries = root?.first?.itemSummaries?[indexPath.item],
                let url = itemSummaries.hrefURL else { return }
        _ = ItemHerf(herfUrl: url) { [weak self] in self?.buyItem.items = (itemSummaries, $0) }
    }
}

// Mark: - UICollectionViewDelegateFlowLayout
extension Browse_Game: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.kWidth * (1/2) - 37.5
        return CGSize(width: width,
                      height: width * 1.6) //Height Based on Text
    }
    
    //Space Between Header and Collection itself
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let height = menuBar.frame.height + 25
        collectionView.scrollIndicatorInsets.top = height
        return UIEdgeInsets(top: height,
                            left: 25,
                            bottom: 0,
                            right: 25)
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
        self.setupLoader()
        self.root?[0].itemSummaries?.removeAll(keepingCapacity: false)
        self.merchRoot = query
        query.retrieveDataByName(offset: 0, loadingImage: loading, { [weak self] in
            self?.root = $0
            
            let indexPath = IndexPath(item: 0, section: 0)
            self?.collectionView?.scrollToItem(at: indexPath, at: .top, animated: true)
        })
    }
}

//Mark: ScrollViewDelegate
extension Browse_Game {
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.height
        if maxOffset - currentOffset <= 40 {
            self.setupPaginationLoader()
        }
    }
}
