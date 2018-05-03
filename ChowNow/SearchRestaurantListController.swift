//
//  SearchRestaurantListController.swift
//  ChowNow
//
//  Created by Justin Wells on 4/30/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class SearchRestaurantListController: UIViewController, UITableViewDataSource, UITableViewDelegate, SearchRestaurantMapControllerDelegate, MainListRestaurantCellDelegate{
    
    var tableView: UITableView!
    var cellIdentifier = "cell"
    var restaurants = [Restaurant]()
    var mapButton: CNCircularButton!
    var category = String()
    var isInitialDownload = true
    var isEmptySearchResult = false
    
    init(category: String) {
        self.category = category
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
        self.downloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupNavigationBar(){
        //Setup Navigation Title
        self.navigationItem.title = self.category.localized()
        
        //Setup Navigation Items
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor.white
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Map Button
        self.setupMapButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        //Setup TableView
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.backgroundColor = CNColor.faintGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = CNColor.faintGray
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.alwaysBounceVertical = true
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(MainListRestaurantCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
    }
    
    func setupMapButton(){
        mapButton = CNCircularButton(frame: CGRect.zero)
        mapButton.setImage(UIImage(named: "map"), for: .normal)
        mapButton.addTarget(self, action: #selector(mapButtonPressed), for: .touchUpInside)
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapButton)
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView, "mapButton": mapButton] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[mapButton(50)]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[mapButton(50)]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func downloadData(){
        //Download Restaurants
        let restaurantManager = RestaurantManager()
        restaurantManager.downloadRestaurants(category: category) { (restaurants) in
            //Change Initial Download Bool
            self.isInitialDownload = false
            
            //Set Restaurants
            self.restaurants = restaurants!
            
            //Set EmptySearchResult Bool
            self.isEmptySearchResult = self.restaurants.count <= 0
            
            self.tableView.reloadData()
        }
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isInitialDownload{
        case true:
            return 1
        case false:
            if(restaurants.count > 8){
                return restaurants.count+1
            }
            else{
                switch isEmptySearchResult{
                case true:
                    return 1
                case false:
                    return restaurants.count
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 && isInitialDownload == false && isEmptySearchResult == true{
            let searchHeader = UIView()
            searchHeader.backgroundColor = UIColor.white
            return searchHeader
        }
        else{
            let sectionHeader = SearchRestaurantsResultsHeader()
            sectionHeader.configure(results: restaurants)
            return sectionHeader
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 && isInitialDownload == false && isEmptySearchResult == true{
            return tableView.frame.height
        }
        else{
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MainListRestaurantCell
        cell.mainListRestaurantCellDelegate = self
        switch isInitialDownload{
        case true:
            cell.configure(restaurant: nil, loading: isInitialDownload)
            return cell
        case false:
            switch isEmptySearchResult{
            case true:
                cell.configureEmpty(title: "emptySearchCategoryString".localized().uppercased(), buttonTitle: "enterANewSearch".localized().uppercased())
            case false:
                cell.configure(restaurant: restaurants[indexPath.row], loading: isInitialDownload)
            }
            return cell
        }
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !(indexPath.item == 0 && isEmptySearchResult == true){
            let restaurantVC = RestaurantController(restaurant: restaurants[indexPath.item])
            self.navigationController?.pushViewController(restaurantVC, animated: true)
        }
    }
    
    //MARK: BarButtonItem Delegates
    func backButtonPressed(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //SearchRestaurantMapController Delegate (passback restaurants from map controller)
    func didDismissSearchRestaurantMapController(restaurants: [Restaurant]){
        self.restaurants = restaurants
        self.isEmptySearchResult = restaurants.count <= 0
        self.tableView.reloadData()
    }
    
    //MainListRestaurantCell Delegate
    func didPressEmptyButton(){
        let searchLocationVC = SearchLocationController()
        self.navigationController?.pushViewController(searchLocationVC, animated: true)
    }
    
    //Button Delegates
    func mapButtonPressed(){
        let mainMapVC = SearchRestaurantMapController()
        mainMapVC.restaurants = self.restaurants
        mainMapVC.delegate = self
        let navVC = NavigationController(rootViewController: mainMapVC)
        self.present(navVC, animated: false, completion: nil)
    }
}
