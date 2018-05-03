//
//  SearchRestaurantCell.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SearchRestaurantCell: UICollectionViewCell{
    
    private var gradientView = UIView()
    private var gradient = CAGradientLayer()
    var imageView = UIImageView()
    var categoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Setup ImageView
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        backgroundColor = UIColor.white
        
        //Setup ImageView
        contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.white
        self.addSubview(imageView)
        
        //Setup Gradient View
        gradientView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        gradientView.isUserInteractionEnabled = false
        self.addSubview(gradientView)
        //Add Gradient to GradientView
        gradient.colors = [UIColor(white: 0.2, alpha: 0.8).cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor]
        gradientView.layer.insertSublayer(gradient, at: 0)
        
        //Setup Category Label
        categoryLabel.textColor = UIColor.white
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 14)
        categoryLabel.numberOfLines = 2
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(categoryLabel)
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupConstraints(){
        let viewDict = ["imageView": imageView, "categoryLabel": categoryLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[categoryLabel]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.addConstraint(NSLayoutConstraint.init(item: categoryLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.height, multiplier: 0.5, constant: 0))
        self.addConstraint(NSLayoutConstraint.init(item: categoryLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Set Frames
        gradient.frame = gradientView.bounds
    }
    
    func configure(image: UIImage, title: String){
        imageView.image = image
        categoryLabel.text = title
    }
}
