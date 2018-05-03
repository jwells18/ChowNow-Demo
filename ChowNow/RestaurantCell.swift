//
//  RestaurantCell.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell{
    
    var nameLabel = UILabel()
    var descriptionLabel = UILabel()
    var priceLabel = UILabel()
    
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
        self.nameLabel.textColor = CNColor.primary
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.nameLabel)
        
        //Setup SubTitle Label
        self.descriptionLabel.textColor = CNColor.primary
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(descriptionLabel)
        
        //Setup SubTitle Label
        self.priceLabel.textColor = CNColor.secondary
        self.priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        self.priceLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(priceLabel)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["nameLabel": nameLabel, "descriptionLabel": descriptionLabel, "priceLabel": priceLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[nameLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[descriptionLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[priceLabel]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[nameLabel(16)]-[descriptionLabel]-[priceLabel(16)]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
        descriptionLabel.sizeToFit()
    }
    
    func configure(menuItem: MenuItem){
        nameLabel.text = "Supreme Pie"
        descriptionLabel.text = "Tomato sauce, mozzarella, pepperoni, sausage, red onion, bell pepeper, black olive and basil."
        priceLabel.text = "9.00"
    }
}
