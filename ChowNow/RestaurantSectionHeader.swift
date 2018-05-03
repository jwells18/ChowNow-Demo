//
//  RestaurantSectionHeader.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import MediaPlayer

class RestaurantSectionHeader: UIButton{
    
    var categoryLabel = UILabel()
    var countLabel =  UIButton()
    var separatorLine = UIView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = CNColor.faintGray
        
        //Setup Title Label
        categoryLabel.textColor = CNColor.primary
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 12)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(categoryLabel)
        
        //Setup Count Label
        countLabel.backgroundColor = CNColor.primary
        countLabel.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        countLabel.titleEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 4)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.clipsToBounds = true
        self.addSubview(countLabel)
        
        //Setup Separator Line
        separatorLine.backgroundColor = UIColor.white
        separatorLine.isUserInteractionEnabled = false
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separatorLine)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func configure(title: String){
        categoryLabel.text = title.uppercased()
        countLabel.setTitle("0", for: .normal)
        countLabel.sizeToFit()
        countLabel.layer.cornerRadius = 8//countLabel.frame.height/2
    }
    
    func setupConstraints() {
         let viewDict = ["categoryLabel": categoryLabel, "countLabel": countLabel, "separatorLine": separatorLine] as [String : Any]
         //Width & Horizontal Alignment
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[categoryLabel]-[countLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorLine]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
         //Height & Vertical Alignment
         self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[categoryLabel(16)]-16-[separatorLine(1)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[countLabel(16)]-16-[separatorLine(1)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}

