//
//  MainTableHeader.swift
//  ChowNow
//
//  Created by Justin Wells on 4/28/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import MediaPlayer

class MainTableHeader: UIView{
    
    var avPlayer = AVPlayer()
    var avPlayerLayer = AVPlayerLayer()
    var containerView = UIView()
    private var gradient = CAGradientLayer()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    
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
        
        //Setup AVPlayer
        self.setupAVPlayer()
        
        //Setup ContainerView
        self.setupContainerView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupAVPlayer(){
        //Setup AVPlayer
        guard let path = Bundle.main.path(forResource: "mainVideo", ofType:"mov") else {
            debugPrint("video not found")
            return
        }
        avPlayer = AVPlayer(url: URL(fileURLWithPath: path))
        avPlayerLayer = AVPlayerLayer(player: avPlayer)
        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        //Prevent background music from being stopped
        _ = try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .mixWithOthers)
        self.layer.addSublayer(avPlayerLayer)
    }
    
    func setupContainerView(){
        //Setup ContainerView
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        //Add Gradient to GradientView
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor(white: 0.2, alpha: 0.8).cgColor]
        containerView.layer.insertSublayer(gradient, at: 0)
        
        //Setup Name Label
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(titleLabel)
        
        //Setup SubTitle Label
        self.subTitleLabel.text = "mainSubTitle".localized().uppercased()
        self.subTitleLabel.textColor = UIColor.white
        self.subTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        self.subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(subTitleLabel)
    }
    
    func configure(user: User?){
        let greetingString = determineGreetingString()
        
        if (user != nil){
            titleLabel.text = String(format: "%@, %@.", greetingString, user!.name)
        }
        else{
            titleLabel.text = greetingString
        }
    }
    
    func setupConstraints() {
        let viewDict = ["containerView": containerView, "titleLabel": titleLabel, "subTitleLabel": subTitleLabel] as [String : Any]
        //Width & Horizontal Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[titleLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[subTitleLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[containerView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.containerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[titleLabel]-[subTitleLabel]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avPlayerLayer.frame = self.frame
        gradient.frame = containerView.bounds
    }
}
