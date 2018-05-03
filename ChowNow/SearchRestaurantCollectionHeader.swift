//
//  SearchRestaurantCollectionHeader.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SearchRestaurantCollectionHeader: UICollectionReusableView{
    
    var headerLabel = UILabel()
    var headerLabelUnderline = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        backgroundColor = UIColor.white
        
        //Setup View All Label
        self.setupheaderLabel()
        
        //Setup View All Underline
        self.setupViewAllUnderline()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupheaderLabel(){
        //Setup View All Label
        headerLabel.text = "topCuisines".localized()
        headerLabel.textColor = CNColor.primary
        headerLabel.font = UIFont.boldSystemFont(ofSize: 22)
        headerLabel.numberOfLines = 0
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerLabel)
    }
    
    func setupViewAllUnderline(){
        headerLabelUnderline.backgroundColor = CNColor.secondary
        headerLabelUnderline.isUserInteractionEnabled = false
        headerLabelUnderline.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerLabelUnderline)
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
        
        let viewDict = ["headerLabel": headerLabel, "headerLabelUnderline": headerLabelUnderline, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[headerLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: headerLabelUnderline, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: headerLabel, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: headerLabelUnderline, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewTop]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][headerLabelUnderline(2)]-2-[headerLabel][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}
