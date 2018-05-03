//
//  RestaurantCategoryViewAllCell.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class RestaurantCategoryViewAllCell: UICollectionViewCell{
    
    var viewAllLabel = UILabel()
    var viewAllLabelUnderline = UIView()
    
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
        self.setupViewAllLabel()
        
        //Setup View All Underline
        self.setupViewAllUnderline()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupViewAllLabel(){
        //Setup View All Label
        viewAllLabel.text = "viewAll".localized()
        viewAllLabel.textColor = CNColor.primary
        viewAllLabel.font = UIFont.boldSystemFont(ofSize: 14)
        viewAllLabel.numberOfLines = 0
        viewAllLabel.textAlignment = .center
        viewAllLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewAllLabel)
    }
    
    func setupViewAllUnderline(){
        viewAllLabelUnderline.backgroundColor = CNColor.secondary
        viewAllLabelUnderline.isUserInteractionEnabled = false
        viewAllLabelUnderline.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(viewAllLabelUnderline)
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
        let spacerViewLeft = UIView()
        spacerViewLeft.isUserInteractionEnabled = false
        spacerViewLeft.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewLeft)
        let spacerViewRight = UIView()
        spacerViewRight.isUserInteractionEnabled = false
        spacerViewRight.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewRight)
        
        let viewDict = ["viewAllLabel": viewAllLabel, "viewAllLabelUnderline": viewAllLabelUnderline,"spacerViewLeft": spacerViewLeft, "spacerViewRight": spacerViewRight, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewLeft(==spacerViewRight)][viewAllLabel][spacerViewRight(==spacerViewLeft)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: viewAllLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: viewAllLabelUnderline, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: viewAllLabel, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: viewAllLabelUnderline, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: viewAllLabel, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewTop]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][viewAllLabel(18)]-2-[viewAllLabelUnderline(2)][spacerViewBottom(spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewLeft, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: viewAllLabel, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewRight, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: viewAllLabel, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0))
    }
}
