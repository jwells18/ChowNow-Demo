//
//  RestaurantController.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class RestaurantController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var restaurant: Restaurant!
    var restaurantHeader: RestaurantHeader!
    var tableView: UITableView!
    private let cellIdentifier = "cell"
    var isInitialDownload = true
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
        
        //Download Data
        //TODO: Download menu for restaurant
        //self.downloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Show navigationBar
        self.navigationController?.isNavigationBarHidden = false
        
        //Remove Gray Hairline
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //Add Navigation hairline back when view disappears
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    func setupNavigationBar(){
        //Setup Navigation Items
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }

    func setupView(){
        //Setup TableView
        self.setupTableView()
        
        //Setup Bottom NavigationBar
        self.setupRestaurantHeader()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        //Setup TableView
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.white
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(RestaurantCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.estimatedSectionHeaderHeight = 49
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func setupRestaurantHeader(){
        //Setup Container View
        restaurantHeader = RestaurantHeader(frame: .zero)
        restaurantHeader.configure(restaurant: self.restaurant)
        restaurantHeader.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(restaurantHeader)
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView, "restaurantHeader": restaurantHeader] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[restaurantHeader]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[restaurantHeader(67)][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        if isInitialDownload{
            return 0
        }
        else{
            return restaurants.count
        }*/
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = RestaurantSectionHeader(frame: .zero)
        sectionHeader.configure(title: "SAMPLE CATEGORY")
        sectionHeader.addTarget(self, action: #selector(sectionHeaderPressed), for: .touchUpInside)
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantCell
        //cell.configure(menuItem: restaurants[indexPath.row])
        return cell
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func sectionHeaderPressed(sender: UIButton){
        //TODO: Insert/Remove Cells when section header is pressed
        let touchPoint = sender.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: touchPoint)
        print("section header pressed \(indexPath)")
        //Show Feature Unavailable
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }

}
