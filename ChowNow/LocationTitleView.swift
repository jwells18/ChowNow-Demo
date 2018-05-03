//
//  LocationTitleView.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LocationTitleView: UIButton{
    
    var locationLabel = UILabel()
    var dropDownImageView = UIImageView()
    
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
        
        //Setup Location Label
        locationLabel.textColor = CNColor.primary
        locationLabel.textAlignment = .center
        locationLabel.font = UIFont.boldSystemFont(ofSize: 16)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(locationLabel)
        
        //Setup Drop Down ImageView
        dropDownImageView.image = UIImage(named: "dropDown")
        dropDownImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dropDownImageView)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let spacerViewLeft = UIView()
        spacerViewLeft.isUserInteractionEnabled = false
        spacerViewLeft.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewLeft)
        let spacerViewRight = UIView()
        spacerViewRight.isUserInteractionEnabled = false
        spacerViewRight.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spacerViewRight)
        
        let viewDict = ["locationLabel": locationLabel, "dropDownImageView": dropDownImageView, "spacerViewLeft": spacerViewLeft, "spacerViewRight": spacerViewRight] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewLeft]-23-[locationLabel]-[dropDownImageView(15)][spacerViewRight]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewLeft, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: spacerViewRight, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewRight, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: spacerViewLeft, attribute: NSLayoutAttribute.width, multiplier: 1, constant: 0))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: locationLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: locationLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: dropDownImageView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: dropDownImageView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 15))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewLeft, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: spacerViewRight, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0))
    }
    
    func configure(title: String){
        locationLabel.text = title
    }
}

    

