//
//  FiltersCell.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class FiltersCell: UITableViewCell{
    
    var mainLabel = UILabel()
    var selectButton = UIButton()
    
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
        
        //Setup Name Label
        self.mainLabel.textColor = CNColor.primary
        self.mainLabel.font = UIFont.systemFont(ofSize: 15)
        self.mainLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.mainLabel)
        
        //Setup Select Button
        self.selectButton.backgroundColor = UIColor.white
        self.selectButton.layer.borderColor = CNColor.faintGray.cgColor
        self.selectButton.layer.borderWidth = 0.5
        self.selectButton.setImage(UIImage(named: "box"), for: .normal)
        self.selectButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(selectButton)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["mainLabel": mainLabel, "selectButton": selectButton] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[selectButton(25)]-[mainLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraint(NSLayoutConstraint.init(item: mainLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: mainLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 25))
        self.addConstraint(NSLayoutConstraint.init(item: selectButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: selectButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 25))
    }
    
    func configure(title: String){
        mainLabel.text = title
    }
}
