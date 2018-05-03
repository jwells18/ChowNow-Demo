//
//  MainListRestaurantCellEmptyView.swift
//  ChowNow
//
//  Created by Justin Wells on 5/2/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class MainListRestaurantCellEmptyView: UIView{
    
    var emptyImageView = UIImageView()
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
        
        //Setup Empty ImageView
        emptyImageView.image = UIImage(named: "map")?.withRenderingMode(.alwaysTemplate)
        emptyImageView.tintColor = CNColor.faintGray
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emptyImageView)
        
        //Setup Empty Label
        self.emptyLabel.textColor = CNColor.faintGray
        self.emptyLabel.textAlignment = .center
        self.emptyLabel.numberOfLines = 0
        self.emptyLabel.font = UIFont.boldSystemFont(ofSize: 16)
        self.emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(emptyLabel)
        
        //Setup Empty Button
        self.emptyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.emptyButton.layer.cornerRadius = 5
        self.emptyButton.clipsToBounds = true
        self.emptyButton.backgroundColor = CNColor.primary
        self.emptyButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.emptyButton)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["emptyImageView": emptyImageView, "emptyLabel": emptyLabel, "emptyButton": emptyButton] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints([NSLayoutConstraint.init(item: emptyImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: emptyImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60)])
        self.addConstraints([NSLayoutConstraint.init(item: emptyLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: emptyLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.95, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: emptyButton, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)])
        self.addConstraints([NSLayoutConstraint.init(item: emptyButton, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.6, constant: 0)])
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[emptyImageView(60)]-20-[emptyLabel]-35-[emptyButton(50)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
}

