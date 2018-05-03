//
//  SearchRestaurantMapController.swift
//  ChowNow
//
//  Created by Justin Wells on 4/30/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import MapKit

protocol SearchRestaurantMapControllerDelegate {
    func didDismissSearchRestaurantMapController(restaurants: [Restaurant])
}

class SearchRestaurantMapController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MKMapViewDelegate, MainMapRestaurantCellDelegate{
    
    var delegate: SearchRestaurantMapControllerDelegate!
    var locationTitleView: LocationTitleView!
    var mapView: MKMapView!
    var searchAreaButton: UIButton!
    var listButton: CNCircularButton!
    var isInitialDownload = false
    var isEmptySearchResult = false
    var restaurants = [Restaurant]()
    var pageControl = UIPageControl()
    var mapManager = MapManager()
    private var annotationIndentifier = "annotationIdentifier"
    private let cellIdentifier = "cell"
    lazy var collectionView: UICollectionView = {
        //Setup CollectionView Flow Layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
        //Setup CollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
        
        //Set isSearchEmptyResults Bool
        isEmptySearchResult = restaurants.count <= 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func setupNavigationBar(){
        //Setup Navigation Title
        self.navigationItem.title = "pizza".localized()
        
        //Setup Navigation Items
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor.white
        
        //Setup mapView
        self.setupMapView()
        
        //Setup CollectionView
        self.setupCollectionView()
        
        //Setup Map Button
        self.setupListButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupMapView(){
        //Setup MapView
        mapView = MKMapView(frame: CGRect.zero)
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        
        //Setup Region
        var region = MKCoordinateRegion()
        region.center.latitude = sampleLocation.coordinate.latitude;
        region.center.longitude = sampleLocation.coordinate.longitude;
        region.span.latitudeDelta = 0.03
        region.span.longitudeDelta = 0.03
        mapView.setRegion(region, animated: false)
        
        //Setup Search parameter pin
        let parameterLocationPin = CNPointAnnotation(pinColor: CNColor.tertiary)
        parameterLocationPin.coordinate = sampleLocation.coordinate
        mapView.addAnnotation(parameterLocationPin)
        
        //Setup Search Area Button
        searchAreaButton = UIButton(frame: .zero)
        searchAreaButton.backgroundColor = CNColor.primary
        searchAreaButton.setTitle("searchInArea".localized().uppercased(), for: .normal)
        searchAreaButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        searchAreaButton.clipsToBounds = true
        searchAreaButton.addTarget(self, action: #selector(searchAreaButtonPressed), for: .touchUpInside)
        mapView.addSubview(searchAreaButton)
        
        //Add Restaurant Map Annotations
        self.addRestaurantMapAnnotations()
    }
    
    func addRestaurantMapAnnotations(){
        mapManager.createRestaurantMapAnotations(restaurants: self.restaurants) { (mapAnnotations) in
            self.mapView.addAnnotations(mapAnnotations)
        }
    }
    
    func setupCollectionView(){
        collectionView.register(MainMapRestaurantCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
    }
    
    func setupListButton(){
        listButton = CNCircularButton(frame: CGRect.zero)
        listButton.setImage(UIImage(named: "list"), for: .normal)
        listButton.addTarget(self, action: #selector(listButtonPressed), for: .touchUpInside)
        listButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(listButton)
    }
    
    func setupConstraints(){
        let viewDict = ["mapView": mapView, "listButton": listButton, "collectionView": collectionView] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[mapView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[listButton(50)]-30-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mapView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[listButton(50)]-30-[collectionView(100)]-25-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    func downloadData(){
        //Change Initial Download Bool
        self.isInitialDownload = true
        
        //Download Restaurants
        let restaurantManager = RestaurantManager()
        restaurantManager.downloadRestaurants(city: currentSearchParameter ?? "") { (restaurants) in
            //Change Initial Download Bool
            self.isInitialDownload = false
            
            self.restaurants = restaurants!
            
            //Set EmptySearchResult Bool
            self.isEmptySearchResult = self.restaurants.count <= 0
            
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        //Set Frames
        searchAreaButton.frame = CGRect(x: self.mapView.frame.width*0.25, y: -70, width: self.mapView.frame.width*0.5, height: 45)
        searchAreaButton.layer.cornerRadius = searchAreaButton.frame.height/2
    }
    
    //CollectionView DataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isInitialDownload{
            return 1
        }
        else{
            switch isEmptySearchResult{
            case true:
                return 1
            case false:
                self.pageControl.numberOfPages = restaurants.count
                return restaurants.count
            }
        }
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.item == 0 && isInitialDownload == false && isEmptySearchResult == true{
            return CGSize(width: collectionView.frame.width-30, height: 100)
        }
        else{
            return CGSize(width: collectionView.frame.width-60, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MainMapRestaurantCell
        cell.mainMapRestaurantCellDelegate = self
        switch isInitialDownload{
        case true:
            cell.configure(restaurant: nil, loading: isInitialDownload)
            return cell
        case false:
            switch isEmptySearchResult{
            case true:
                cell.configureEmpty(title: "emptySearchString".localized().uppercased(), buttonTitle: "enterANewSearch".localized().uppercased())
            case false:
                cell.configure(restaurant: restaurants[indexPath.item], loading: isInitialDownload)
            }
            return cell
        }
    }
    
    //CollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !(indexPath.item == 0 && isEmptySearchResult == true){
            let restaurantVC = RestaurantController(restaurant: restaurants[indexPath.item])
            self.navigationController?.pushViewController(restaurantVC, animated: true)
        }
    }
    
    //ScrollView Delegates
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //Scroll CollectionView cell into place when scrolling
        //NOTE: Enabling paging is preferred, but not possible given we want to show a preview of the next cell in the collectionView
        if scrollView == collectionView{
            let itemWidth = Float(collectionView.frame.width-60)
            let itemSpacing = Float(15)
            
            let pageWidth = Float(itemWidth + itemSpacing)
            let targetXContentOffset = Float(targetContentOffset.pointee.x)
            let contentWidth = Float(collectionView.contentSize.width  )
            var newPage = Float(self.pageControl.currentPage)
            
            if velocity.x == 0 {
                newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
            } else {
                newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
                if newPage < 0 {
                    newPage = 0
                }
                if (newPage > contentWidth / pageWidth) {
                    newPage = ceil(contentWidth / pageWidth) - 1.0
                }
            }
            
            self.pageControl.currentPage = Int(newPage)
            let point = CGPoint (x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
            targetContentOffset.pointee = point
        }
    }
    
    //Button Delegates
    func backButtonPressed(){
        self.dismiss(animated: false, completion: nil)
    }
    
    func listButtonPressed(){
        delegate.didDismissSearchRestaurantMapController(restaurants: self.restaurants)
        self.dismiss(animated: false, completion: nil)
    }
    
    func searchAreaButtonPressed(){
        //Download Data
        //NOTE: Search area is not implemented yet, but can quickly be accomplished with GeoFire
        //self.downloadData()
        
        //Hide Search Area Button with animation
        UIView.animate(withDuration: 0.3) {
            self.searchAreaButton.frame = CGRect(x: self.mapView.frame.width*0.25, y: -70, width: self.mapView.frame.width*0.5, height: 40)
        }
    }
    
    //MainMapRestaurantCell Delegate
    func didPressEmptyButton(){
        let searchLocationVC = SearchLocationController()
        self.navigationController?.pushViewController(searchLocationVC, animated: true)
    }
    
    //MapView Delegate
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        //Show Search In Area Button
        UIView.animate(withDuration: 0.3) {
            self.searchAreaButton.frame = CGRect(x: self.mapView.frame.width*0.25, y: 16, width: self.mapView.frame.width*0.5, height: 40)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIndentifier)
        
        if (annotationView == nil){
            if annotation.isKind(of: CNMapAnnotation.self){
                //TODO: Add logic for when restaurant is closed and change to closed marker
                let customAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIndentifier)
                customAnnotation.image = UIImage(named: "mapMarkerOpen")
                annotationView = customAnnotation
            }
            else{
                let customAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIndentifier)
                let colorPointAnnotation = annotation as! CNPointAnnotation
                customAnnotation.pinTintColor = colorPointAnnotation.pinColor
                annotationView = customAnnotation
            }
        }
        else{
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //Show larger white marker when restaurant annotation is selected
        if (view.annotation?.isKind(of: CNMapAnnotation.self))!{
            view.image = UIImage(named: "mapMarkerSelected")
            let selectedAnnotation = view.annotation as! CNMapAnnotation
            let selectedRestaurant = selectedAnnotation.restaurant!
            let restaurantItemIndex = self.restaurants.index(of: selectedRestaurant)
            let restaurantIndexPath = IndexPath(item: restaurantItemIndex!, section: 0)
            self.collectionView.scrollToItem(at: restaurantIndexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        //Show default marker when restaurant annotation is deselected
        if (view.annotation?.isKind(of: CNMapAnnotation.self))!{
            view.image = UIImage(named: "mapMarkerOpen")
        }
    }
}
