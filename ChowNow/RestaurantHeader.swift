//
//  RestaurantHeader.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
class RestaurantHeader: UIView{
    
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = UIColor.white
        
        //Add Shadow
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        //Setup Name Label
        titleLabel.textColor = CNColor.primary
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        //Setup SubTitle Label
        subTitleLabel.textColor = CNColor.primary
        subTitleLabel.textAlignment = .center
        subTitleLabel.font = UIFont.systemFont(ofSize: 14)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitleLabel)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func configure(restaurant: Restaurant){
        titleLabel.text = restaurant.name
        subTitleLabel.attributedText = determineRestaurantCategoryString(restaurant: restaurant)
    }
    
    func setupConstraints() {
        let spacerViewBottom = UIView()
        spacerViewBottom.isUserInteractionEnabled = false
        spacerViewBottom.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewBottom)
        
         let viewDict = ["titleLabel": titleLabel, "subTitleLabel": subTitleLabel, "spacerViewBottom": spacerViewBottom] as [String : Any]
         //Width & Horizontal Alignment
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subTitleLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
         //Height & Vertical Alignment
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel(28)]-2-[subTitleLabel(18)][spacerViewBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}

