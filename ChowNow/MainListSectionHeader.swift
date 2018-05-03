//
//  MainListSectionHeader.swift
//  ChowNow
//
//  Created by Justin Wells on 4/30/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class MainListSearchHeader: UIView{
    
    var titleView = LocationTitleView()
    var searchHeader = CNSearchHeader()
    
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
        
        //Setup TitleView
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleView)
        
        //Setup Search Header
        searchHeader.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchHeader)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["titleView": titleView, "searchHeader": searchHeader] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[searchHeader]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleView(44)][searchHeader(44)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}
