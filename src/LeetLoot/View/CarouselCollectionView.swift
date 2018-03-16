//
//  CarouselCollectionView.swift
//  LeetLoot
//
//  Created by Katherine Bajno on 2/9/18.
//  Copyright © 2018 Kiarash Teymoury. All rights reserved.
//

import UIKit


class CarouselCollectionView: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    private let cellId = "cellId"
    
    var isDownloading: Bool = false
    
    private var loadingIndicator = { () -> UIActivityIndicatorView in
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            view.color = .lightBlue
            view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    func setupViews(){
        backgroundColor = .white
        loadData()
        addSubview(itemsCollectionView)
        addSubview(loadingIndicator)

        //to generate multiple cells in nested collection view
        itemsCollectionView.dataSource = self
        itemsCollectionView.delegate = self
        
        //register item cell to the collection view
        itemsCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        
        //expand from left to right edge
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-15-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": itemsCollectionView]))
        
        //expand from top to bottom
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": itemsCollectionView]))
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
   //number of cells return in section, this will change based on if it's events or games
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return root?.itemsSummary?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ItemCell {
            let imageURL = root?.itemsSummary?[indexPath.item].imgURL
            cell.merchImage.downloadImages(url: imageURL ?? "")
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isDownloading {
            isDownloading = true
            print("isDownloading")
            guard   let itemSummaries = root?.first?.itemSummaries?[indexPath.item],
                let url = itemSummaries.hrefURL else { return }
            
            _ = ItemHerf(herfUrl: url) { [weak self] in
                self?.buyItem.items = (itemSummaries, $0)
                self?.isDownloading = false
                print("Done Downloading")
            }
        }
    }
    
    //sizing of cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
    
    //adjust line spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
    
    fileprivate var root: [Root]? {
        didSet {
            DispatchQueue.main.async {
                self.itemsCollectionView.reloadData()
            }
        }
    }
    
    func loadData() {
        let query = Root(queryKey: "e3 expo", filterBy: .All_Items, sortBy: .Best_Match, limit: 8)
        query.retrieveDataByName(offset: 0, loadingIndicator) { [weak self] in
            self?.root = $0
        }
    }
    
    lazy var buyItem = { () -> Buy_Filter in
        let view = Buy_Filter()
        return view
    }()
}

//cell where the event, game, or merch is displayed in carousel
class ItemCell: UICollectionViewCell{
    
    let merchImage = { () -> customeImage in
        let image = customeImage(frame: .zero)
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        backgroundColor = .clear
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.softGray.cgColor
        addSubview(merchImage)
        
        NSLayoutConstraint.activate([
            merchImage.leftAnchor.constraint(equalTo: leftAnchor),
            merchImage.rightAnchor.constraint(equalTo: rightAnchor),
            merchImage.topAnchor.constraint(equalTo: topAnchor),
            merchImage.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
