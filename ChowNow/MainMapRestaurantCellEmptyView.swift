//
//  MainMapRestaurantCellEmptyView.swift
//  ChowNow
//
//  Created by Justin Wells on 5/2/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class MainMapRestaurantCellEmptyView: UIView{
    
    var emptyLabel = UILabel()
    var emptyButton = UIButton()
    
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
        
        //Setup Empty Label
        self.emptyLabel.textColor = CNColor.primary
        self.emptyLabel.textAlignment = .center
        self.emptyLabel.font = UIFont.boldSystemFont(ofSize: 11)
        self.emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emptyLabel)
        
        //Setup Empty Button
        self.emptyButton.setTitleColor(CNColor.primary, for: .normal)
        self.emptyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        self.emptyButton.layer.cornerRadius = 5
        self.emptyButton.clipsToBounds = true
        self.emptyButton.layer.borderWidth = 1
        self.emptyButton.layer.borderColor = CNColor.primary.cgColor
        self.emptyButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.emptyButton)
        
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
        
        let viewDict = ["emptyLabel": emptyLabel, "emptyButton": emptyButton, "spacerViewTop": spacerViewTop, "spacerViewBottom": spacerViewBottom] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[emptyLabel]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[emptyButton]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[spacerViewTop]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[spacerViewBottom]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(>=16)][emptyLabel]-[emptyButton(40)][spacerViewBottom(>=16)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints([NSLayoutConstraint.init(item: spacerViewTop, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: spacerViewBottom, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: spacerViewBottom, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: spacerViewTop, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)])
    }
}
