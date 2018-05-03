//
//  SearchLocationController.swift
//  ChowNow
//
//  Created by Justin Wells on 4/28/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SearchLocationController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var searchHeader = SearchLocationHeader()
    var tableView: UITableView!
    var cellIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Show NavigationBar
        self.navigationController?.isNavigationBarHidden = false
        searchHeader.searchField.becomeFirstResponder()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Title
        self.navigationItem.title = "search".localized()
        
        //Setup Navigation Items
        self.navigationItem.hidesBackButton = true
        if currentSearchParameter != nil{
            let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
            self.navigationItem.leftBarButtonItem = backButton
        }
        
        //Remove Gray Hairline
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor.white
        
        //Setup Search Header
        self.setupSearchHeader()
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupSearchHeader(){
        //NOTE: For demo purposes, Los Angeles is the only available location
        searchHeader.searchField.text = sampleLocationName
        searchHeader.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchHeader)
    }
    
    func setupTableView(){
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(SearchLocationCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func setupConstraints(){
        let viewDict = ["searchHeader": searchHeader, "tableView": tableView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[searchHeader]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[searchHeader(80)][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchLocationCell
        switch indexPath.row {
        case 0:
            cell.mainLabel.text = "Use Current Location"
            cell.mainSubLabel.text = "Location services not enabled"
        case 1:
            cell.mainLabel.text = nil
            cell.mainSubLabel.text = sampleLocationNameLong
            return cell
        default:
            return cell
        }
        
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            //Show Feature Unavailable
            //TODO: Include current location tracking
            self.present(featureUnavailableAlert(), animated: true, completion: nil)
            break
        case 1:
            //Set Current Location Parameter
            //NOTE: For demo purposes, Los Angeles is the only available location
            UserDefaults.standard.set(sampleLocationName, forKey: "currentSearchParameter")
            UserDefaults.standard.synchronize()
            currentSearchParameter = UserDefaults.standard.object(forKey: "currentSearchParameter") as? String
            _ = self.navigationController?.popViewController(animated: false)
            break
        default:
            break
        }
    }
    
    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
}
