//
//  SearchRestaurantsResultsHeader.swift
//  ChowNow
//
//  Created by Justin Wells on 4/30/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SearchRestaurantsResultsHeader: UIView{
    
    var headerLabel = UILabel()
    var headerLabelUnderline = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        headerLabel.textColor = UIColor.lightGray
        headerLabel.font = UIFont.boldSystemFont(ofSize: 14)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerLabel)
    }
    
    func setupViewAllUnderline(){
        headerLabelUnderline.backgroundColor = CNColor.faintGray
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
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[headerLabelUnderline]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewTop]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spacerViewBottom]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[spacerViewTop(==spacerViewBottom)][headerLabel][spacerViewBottom(==spacerViewTop)][headerLabelUnderline(0.5)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func configure(results: [Restaurant]){
        headerLabel.text = String(format: "%@ %@",String(results.count), "results".localized().uppercased())
    }
}

