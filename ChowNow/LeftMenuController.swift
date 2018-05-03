//
//  LeftMenuController.swift
//  ChowNow
//
//  Created by Justin Wells on 4/28/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class LeftMenuController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var imageView: UIImageView!
    private let cellIdentifier = "cell"
    var tableView: UITableView!
    var footerView: FiltersTableHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup View
        self.setupView()
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor.white
        
        //Setup ImageView
        self.setupImageView()
        
        //Setup TableView
        self.setupTableView()
        
        //Setup FooterView
        self.setupFooterView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupImageView(){
        imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "logo1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
    }
    
    func setupTableView(){
        //Setup TableView
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func setupFooterView(){
        footerView = FiltersTableHeader(frame: .zero)
        footerView.headerLabel.text = currentUser.name
        footerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(footerView)
    }
    
    func setupConstraints(){
        let viewDict = ["imageView": imageView, "tableView": tableView, "footerView": footerView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView(70)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[footerView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[imageView(70)]-30-[tableView]-30-[footerView(50)]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = settingsTitles[indexPath.row].localized()
        cell.textLabel?.textColor = CNColor.primary
        cell.textLabel?.font = UIFont.systemFont(ofSize: 26)
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.slideMenuController()?.closeLeft()
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
}

