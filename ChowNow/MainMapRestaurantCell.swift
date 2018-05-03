//
//  MainMapRestaurantCell.swift
//  ChowNow
//
//  Created by Justin Wells on 4/28/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

protocol MainMapRestaurantCellDelegate {
    func didPressEmptyButton()
}

class MainMapRestaurantCell: UICollectionViewCell{
    
    var mainMapRestaurantCellDelegate: MainMapRestaurantCellDelegate!
    var nameLabel = UILabel()
    var categoryLabel = UILabel()
    var statusLabel = UILabel()
    var locationLabel = UILabel()
    var downloadingActivityView = UIActivityIndicatorView()
    var emptyView = MainMapRestaurantCellEmptyView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = UIColor.white
        
        //Setup Name Label
        self.nameLabel.textColor = CNColor.primary
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.nameLabel)
        
        //Setup SubTitle Label
        self.categoryLabel.textColor = CNColor.primary
        self.categoryLabel.font = UIFont.systemFont(ofSize: 14)
        self.categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(categoryLabel)
        
        //Setup SubTitle Label
        self.statusLabel.textColor = CNColor.secondary
        self.statusLabel.font = UIFont.boldSystemFont(ofSize: 11)
        self.statusLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(statusLabel)
        
        //Setup SubTitle Label
        self.locationLabel.textColor = CNColor.primary
        self.locationLabel.font = UIFont.boldSystemFont(ofSize: 11)
        self.locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(locationLabel)
        
        //Setup Empty View
        emptyView.isHidden = true
        emptyView.emptyButton.addTarget(self, action: #selector(self.emptySearchButtonPressed), for: .touchUpInside)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emptyView)
        
        //Setup Downloading ActivityView
        self.downloadingActivityView.activityIndicatorViewStyle = .gray
        self.backgroundView = downloadingActivityView
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let spacerViewTop = UIView()
        spacerViewTop.isUserInteractionEnabled = false
        spacerViewTop.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewTop)
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        
        let viewDict = ["nameLabel": nameLabel, "categoryLabel": categoryLabel, "statusLabel": statusLabel, "locationLabel": locationLabel, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom, "emptyView": emptyView] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[nameLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[categoryLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[statusLabel]-[locationLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[spacerViewTop]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[spacerViewBottom]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[emptyView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(>=16)][nameLabel(24)]-4-[categoryLabel(18)]-4-[statusLabel(15)][spacerViewBottom(>=16)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: locationLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: statusLabel, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: locationLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: statusLabel, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: spacerViewTop, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: spacerViewBottom, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: spacerViewBottom, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: spacerViewTop, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)])
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[emptyView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configureEmpty(title: String, buttonTitle: String){
        nameLabel.isHidden = true
        categoryLabel.isHidden = true
        statusLabel.isHidden = true
        locationLabel.isHidden = true
        emptyView.emptyLabel.text = title
        emptyView.emptyButton.setTitle(buttonTitle, for: .normal)
        emptyView.isHidden = false
    }
    
    func configure(restaurant: Restaurant?, loading: Bool){
        switch loading{
        case true:
            downloadingActivityView.startAnimating()
            nameLabel.text = nil
            nameLabel.isHidden = true
            categoryLabel.text = nil
            categoryLabel.isHidden = true
            statusLabel.text = nil
            statusLabel.isHidden = true
            locationLabel.text = nil
            locationLabel.isHidden = true
            emptyView.isHidden = true
            break
        case false:
            downloadingActivityView.stopAnimating()
            nameLabel.text = restaurant?.name
            nameLabel.isHidden = false
            categoryLabel.attributedText = determineRestaurantCategoryString(restaurant: restaurant)
            categoryLabel.isHidden = false
            statusLabel.text = determineRestaurantStatusString(restaurant: restaurant)
            statusLabel.isHidden = false
            locationLabel.text = restaurant?.distance.uppercased()
            locationLabel.isHidden = false
            emptyView.isHidden = true
            break
        }
    }
    
    func emptySearchButtonPressed(){
        mainMapRestaurantCellDelegate.didPressEmptyButton()
    }
}
