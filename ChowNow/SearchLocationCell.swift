//
//  SearchLocationCell.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SearchLocationCell: UITableViewCell{
    
    var mainLabel = UILabel()
    var mainSubLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Setup View
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.backgroundColor = CNColor.dimGray
        self.selectionStyle = .none
        
        //Setup Name Label
        self.mainLabel.textColor = UIColor.lightGray
        self.mainLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainLabel)
        
        //Setup SubTitle Label
        self.mainSubLabel.textColor = CNColor.primary
        self.mainSubLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.mainSubLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainSubLabel)
        
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
        
        let viewDict = ["mainLabel": mainLabel, "mainSubLabel": mainSubLabel, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[mainLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[mainSubLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[spacerViewTop]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[spacerViewBottom]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][mainLabel(<=16)]-2-[mainSubLabel(<=16)][spacerViewBottom(==spacerViewTop)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
    }
    
    func configure(title: String?, subTitle: String?){
        mainLabel.text = title
        mainSubLabel.text = subTitle
    }
}
