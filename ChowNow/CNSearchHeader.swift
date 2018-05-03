//
//  CNSearchHeader.swift
//  ChowNow
//
//  Created by Justin Wells on 4/28/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class CNSearchHeader: UIView{
    
    var searchIconButton = UIButton()
    var searchFieldButton = UIButton()
    var separatorVerticalLine = UIView()
    var filterIconButton = UIButton()
    var filterButton = UIButton()
    var separatorHorizontalTopLine = UIView()
    var separatorHorizontalBottomLine = UIView()
    
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
        
        //Setup Search Icon Button
        searchIconButton.setImage(UIImage(named: "search"), for: .normal)
        searchIconButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchIconButton)
        
        //Setup Search Button Field
        searchFieldButton.setTitle("search".localized(), for: .normal)
        searchFieldButton.setTitleColor(UIColor.lightGray, for: .normal)
        searchFieldButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        searchFieldButton.contentHorizontalAlignment = .left
        searchFieldButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(searchFieldButton)
        
        //Setup Search Icon Button
        filterIconButton.setImage(UIImage(named: "filter"), for: .normal)
        filterIconButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(filterIconButton)
        
        //Setup Search Button Field
        filterButton.setTitle("filters".localized().uppercased(), for: .normal)
        filterButton.setTitleColor(CNColor.primary, for: .normal)
        filterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        filterButton.contentHorizontalAlignment = .left
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(filterButton)
        
        //Setup Separator Line
        separatorVerticalLine.backgroundColor = UIColor.lightGray
        separatorVerticalLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separatorVerticalLine)
        
        //Setup Separator Line
        separatorHorizontalTopLine.backgroundColor = CNColor.faintGray
        separatorHorizontalTopLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separatorHorizontalTopLine)
        
        //Setup Separator Line
        separatorHorizontalBottomLine.backgroundColor = CNColor.faintGray
        separatorHorizontalBottomLine.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(separatorHorizontalBottomLine)

        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["separatorHorizontalTopLine": separatorHorizontalTopLine, "searchIconButton": searchIconButton, "searchFieldButton": searchFieldButton, "separatorVerticalLine": separatorVerticalLine, "filterIconButton": filterIconButton, "filterButton": filterButton, "separatorHorizontalBottomLine": separatorHorizontalBottomLine] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[searchIconButton(20)]-[searchFieldButton]-[separatorVerticalLine(1)]-[filterIconButton(20)]-[filterButton(<=150)]-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorHorizontalTopLine]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[separatorHorizontalBottomLine]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints([NSLayoutConstraint.init(item: separatorHorizontalTopLine, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: searchIconButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: searchFieldButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: searchIconButton, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: separatorVerticalLine, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: filterIconButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: filterButton, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: filterIconButton, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: separatorHorizontalBottomLine, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: separatorHorizontalTopLine, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 0.5)])
        self.addConstraints([NSLayoutConstraint.init(item: searchIconButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)])
        self.addConstraints([NSLayoutConstraint.init(item: searchFieldButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: separatorVerticalLine, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 16)])
        self.addConstraints([NSLayoutConstraint.init(item: filterIconButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 20)])
        self.addConstraints([NSLayoutConstraint.init(item: filterButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: separatorHorizontalBottomLine, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 0.5)])
    }
}
