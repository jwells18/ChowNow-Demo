//
//  MainRestaurantCategoryCell.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol MainRestaurantCategoryCellDelegate{
    func didPressRestaurantCategoryCell(indexPath: IndexPath)
}

class MainRestaurantCategoryCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var delegate: MainRestaurantCategoryCellDelegate!
    private let categoryCellIdentifier = "categoryCell"
    private let headerCellIdentifier = "headerCell"
    private let viewAllCellIdentifier = "viewAllCell"
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = UIColor.white
        self.selectionStyle = .none
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupCollectionView(){
        //Setup CollectionView
        collectionView.register(RestaurantCategoryHeaderCell.self, forCellWithReuseIdentifier: headerCellIdentifier)
        collectionView.register(RestaurantCategoryCell.self, forCellWithReuseIdentifier: categoryCellIdentifier)
        collectionView.register(RestaurantCategoryViewAllCell.self, forCellWithReuseIdentifier: viewAllCellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
    }
    
    func setupConstraints(){
        let viewDict = ["collectionView": collectionView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-24-[collectionView(100)]-24-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cuisineCategories.prefix(5).count+2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize{
        let item = indexPath.item
        switch item{
        case _ where item == 0 || item > cuisineCategories.prefix(5).count:
            return CGSize(width: collectionView.frame.height*1.3, height: collectionView.frame.height)
        default:
            return CGSize(width: collectionView.frame.height*1.4, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = indexPath.item
        switch item{
        case _ where item == 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerCellIdentifier, for: indexPath) as! RestaurantCategoryHeaderCell
            return cell
        case _ where item > 0 && item <= cuisineCategories.prefix(5).count:
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as! RestaurantCategoryCell
        cell.configure(image: cuisineCategoryImages.prefix(5)[indexPath.item-1]!, title: cuisineCategories.prefix(5)[indexPath.item-1].localized())
        return cell
        case _ where item > cuisineCategories.prefix(5).count:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewAllCellIdentifier, for: indexPath) as! RestaurantCategoryViewAllCell
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdentifier, for: indexPath) as! RestaurantCategoryCell
            return cell
        }
    }
    
    //CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate.didPressRestaurantCategoryCell(indexPath: indexPath)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
    }
}
