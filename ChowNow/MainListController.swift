//
//  MainListController.swift
//  ChowNow
//
//  Created by Justin Wells on 4/27/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import MediaPlayer

class MainListController: UIViewController, UITableViewDataSource, UITableViewDelegate, MainRestaurantCategoryCellDelegate, MainMapControllerDelegate, MainListRestaurantCellDelegate {
    
    var menuButton: UIButton!
    var searchHeader: MainListSearchHeader!
    var scrollView: UIScrollView!
    var lastContentOffset = CGFloat(0)
    var scrollViewHeader = MainTableHeader()
    var tableView: UITableView!
    var mapButton: CNCircularButton!
    private let cellIdentifier = "cell"
    private let categoryCellIdentifier = "categoryCell"
    var isInitialDownload = true
    var isEmptySearchResult = false
    var restaurants = [Restaurant]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup View
        self.setupView()
        
        //Download Data
        self.downloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
        
        //Determine if currentUser has a current search parameter
        if currentSearchParameter == nil{
            let searchLocationVC = SearchLocationController()
            self.navigationController?.pushViewController(searchLocationVC, animated: true)
        }
        
        //Add AVPlayer Observers
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: scrollViewHeader.avPlayer.currentItem)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForegroundNotification), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackgroundNotification), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        scrollViewHeader.avPlayer.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor.white
        
        //Setup ScrollView
        self.setupScrollView()
        
        //Setup ScrollView Header
        self.setupScrollViewHeader()
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Menu Button
        self.setupMenuButton()
        
        //Setup Map Button
        self.setupMapButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupScrollView(){
        scrollView = UIScrollView(frame: .zero)
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor.red
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: w, height: h)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(scrollView)
    }
    
    func setupScrollViewHeader(){
        //Setup ScrollView Header
        scrollViewHeader = MainTableHeader(frame: .zero)
        scrollViewHeader.configure(user: currentUser)
        scrollViewHeader.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(scrollViewHeader)
    }
    
    func setupTableView(){
        //Setup TableView
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = CNColor.faintGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.bounces = false
        tableView.separatorColor = CNColor.faintGray
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(MainListRestaurantCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(MainRestaurantCategoryCell.self, forCellReuseIdentifier: categoryCellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(tableView)
    }
    
    func setupMenuButton(){
        menuButton = UIButton(frame: CGRect(x: 16, y: 28, width: 28, height: 28))
        menuButton.tintColor = UIColor.white
        menuButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        self.view.addSubview(menuButton)
    }
    
    func setupMapButton(){
        mapButton = CNCircularButton(frame: CGRect.zero)
        mapButton.setImage(UIImage(named: "map"), for: .normal)
        mapButton.addTarget(self, action: #selector(mapButtonPressed), for: .touchUpInside)
        mapButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapButton)
    }
    
    func setupConstraints(){
        let viewDict = ["scrollView": scrollView, "scrollViewHeader":scrollViewHeader, "tableView": tableView, "mapButton": mapButton] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[mapButton(50)]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.scrollView.addConstraints([NSLayoutConstraint.init(item: scrollViewHeader, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)])
        self.scrollView.addConstraints([NSLayoutConstraint.init(item: tableView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0)])
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[mapButton(50)]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollViewHeader][tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.scrollView.addConstraints([NSLayoutConstraint.init(item: scrollViewHeader, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 0.8, constant: 0)])
        self.scrollView.addConstraints([NSLayoutConstraint.init(item: tableView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0)])
    }
    
    func downloadData(){
        //Download Restaurants
        let restaurantManager = RestaurantManager()
        restaurantManager.downloadRestaurants(city: currentSearchParameter ?? "") { (restaurants) in
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Setup Search Header
        searchHeader = MainListSearchHeader(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 64+44))
        searchHeader.titleView.configure(title: currentSearchParameter ?? "")
        searchHeader.titleView.addTarget(self, action: #selector(titleViewPressed), for: .touchUpInside)
        searchHeader.searchHeader.searchIconButton.addTarget(self, action: #selector(searchFieldButtonPressed), for: .touchUpInside)
        searchHeader.searchHeader.searchFieldButton.addTarget(self, action: #selector(searchFieldButtonPressed), for: .touchUpInside)
        searchHeader.searchHeader.filterIconButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        searchHeader.searchHeader.filterButton.addTarget(self, action: #selector(filterButtonPressed), for: .touchUpInside)
        
        return searchHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64+44
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
        let row = indexPath.row
        switch row{
        case _ where row < 8 :
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MainListRestaurantCell
            cell.mainListRestaurantCellDelegate = self
            switch isInitialDownload{
            case true:
                cell.configure(restaurant: nil, loading: isInitialDownload)
            case false:
                switch isEmptySearchResult{
                case true:
                    cell.configureEmpty(title: "emptySearchStringLong".localized().uppercased(), buttonTitle: "tryANewLocation".localized().uppercased())
                case false:
                    cell.configure(restaurant: restaurants[indexPath.row], loading: isInitialDownload)
                }
            }
            return cell
        case _ where row == 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdentifier, for: indexPath) as! MainRestaurantCategoryCell
            cell.delegate = self
            return cell
        case _ where row > 8 && row <= restaurants.count:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MainListRestaurantCell
            cell.mainListRestaurantCellDelegate = self
            cell.configure(restaurant: restaurants[indexPath.row-1], loading: isInitialDownload)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MainListRestaurantCell
            return cell
        }
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        switch row{
        case _ where row < 8 :
            switch isInitialDownload{
            case true:
                break
            case false:
                switch isEmptySearchResult{
                case true:
                    break
                case false:
                    let restaurantVC = RestaurantController(restaurant: restaurants[indexPath.item])
                    self.navigationController?.pushViewController(restaurantVC, animated: true)
                }
            }
        case _ where row == 8:
            break
        case _ where row > 8 && row <= restaurants.count:
            let restaurantVC = RestaurantController(restaurant: restaurants[indexPath.item-1])
            self.navigationController?.pushViewController(restaurantVC, animated: true)
        default:
            break
        }
    }
    
    func didPressRestaurantCategoryCell(indexPath: IndexPath){
        let item = indexPath.item
        switch item{
        case _ where item > 0 && item <= cuisineCategories.prefix(5).count:
            let searchRestaurantListVC = SearchRestaurantListController(category: cuisineCategories.prefix(5)[indexPath.item-1])
            self.navigationController?.pushViewController(searchRestaurantListVC, animated: true)
            break
        case _ where item > cuisineCategories.prefix(5).count:
            let searchRestaurantVC = SearchRestaurantController()
            let navVC = NavigationController(rootViewController: searchRestaurantVC)
            self.present(navVC, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    //ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            //Prevent tableView from scrolling when scrollView Header is visible
            tableView.isScrollEnabled = (self.scrollView.contentOffset.y >= scrollViewHeader.frame.height)
            
            //Menu Button Animation (when scrolling)
            if scrollView.contentOffset.y < 118{
                menuButton.tintColor = UIColor.white
                menuButton.center = CGPoint(x: 30, y: 42)
            }
            else if scrollView.contentOffset.y >= 118 && scrollView.contentOffset.y < scrollViewHeader.frame.height-162{
                menuButton.tintColor = UIColor.white
                if (self.lastContentOffset > scrollView.contentOffset.y && menuButton.center.x < 30) {
                    //Scroll Down
                    menuButton.center.x = menuButton.center.x+(scrollView.contentOffset.y-118)
                }
                else if (self.lastContentOffset < scrollView.contentOffset.y && menuButton.center.x > -14) {
                    //Scrolling Up
                    menuButton.center.x = menuButton.center.x-(scrollView.contentOffset.y-118)
                }
                menuButton.center.y = 42
            }
            else if scrollView.contentOffset.y > scrollViewHeader.frame.height-162{
                menuButton.tintColor = CNColor.primary
                if (self.lastContentOffset > scrollView.contentOffset.y && menuButton.center.x > -14) {
                    //Scrolling Down
                    menuButton.center.x = menuButton.center.x-(scrollView.contentOffset.y-(scrollViewHeader.frame.height-162))
                }
                else if (self.lastContentOffset < scrollView.contentOffset.y && menuButton.center.x < 30) {
                    //Scrolling Up
                    menuButton.center.x = menuButton.center.x+(scrollView.contentOffset.y-(scrollViewHeader.frame.height-162))
                }
                
                menuButton.center.y = (scrollViewHeader.frame.height-scrollView.contentOffset.y)+searchHeader.titleView.center.y
            }
            
            self.lastContentOffset = scrollView.contentOffset.y
        }
        
        //Enable tableView scrolling when scrollView Header is not visible
        if scrollView == self.tableView {
            self.tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
        }
    }
    
    //AVPlayer Delegate
    func playerItemDidReachEnd(notification: NSNotification){
        let item = notification.object as! AVPlayerItem
        item.seek(to: kCMTimeZero)
        scrollViewHeader.avPlayer.play()
    }
    
    func appWillEnterForegroundNotification() {
        scrollViewHeader.avPlayer.play()
    }
    
    func appDidEnterBackgroundNotification() {
        scrollViewHeader.avPlayer.pause()
    }
    
    //MainMapController Delegate (pass back restaurants from a map search)
    func didDismissMainMapController(restaurants: [Restaurant]){
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
        let mainMapVC = MainMapController()
        mainMapVC.restaurants = self.restaurants
        mainMapVC.delegate = self
        self.navigationController?.pushViewController(mainMapVC, animated: false)
    }
    
    func menuButtonPressed(){
        self.slideMenuController()?.openLeft()
    }
    
    func titleViewPressed(){
        let searchLocationVC = SearchLocationController()
        self.navigationController?.pushViewController(searchLocationVC, animated: true)
    }
    
    func searchFieldButtonPressed(){
        let searchRestaurantVC = SearchRestaurantController()
        let navVC = NavigationController(rootViewController: searchRestaurantVC)
        self.present(navVC, animated: false, completion: nil)
    }
    
    func filterButtonPressed(){
        let filtersVC = FiltersController()
        let navVC = NavigationController(rootViewController: filtersVC)
        self.present(navVC, animated: true, completion: nil)
    }
}

