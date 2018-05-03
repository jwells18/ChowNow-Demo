//
//  FiltersController.swift
//  ChowNow
//
//  Created by Justin Wells on 4/29/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit

class FiltersController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    private let cellIdentifier = "cell"
    var tableView: UITableView!
    var tableViewHeader: FiltersTableHeader!
    var applyFiltersButton: CNFloatingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup NavigationBar
        self.setupNavigationBar()
        
        //Setup View
        self.setupView()
    }
    
    func setupNavigationBar(){
        //Setup Navigation Title
        self.navigationItem.title = "filters".localized()

        //Setup Navigation Items
        let cancelButton = UIBarButtonItem(image: UIImage(named: "cancel"), style: .plain, target: self, action: #selector(self.cancelButtonPressed))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        //Remove Gray Hairline
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Add navigationBar hairline
        let bottomNavViewLine = CALayer()
        bottomNavViewLine.frame = CGRect(x: 0, y: 44, width: (self.navigationController?.navigationBar.frame.width)!, height: 0.5)
        bottomNavViewLine.backgroundColor = CNColor.faintGray.cgColor
        self.navigationController?.navigationBar.layer.addSublayer(bottomNavViewLine)
    }
    
    func setupView(){
        self.view.backgroundColor = UIColor.white
        
        //Setup TableView
        self.setupTableView()
        
        //Setup Floating Button
        self.setupFloatingButton()
        
        //Setup Constraints
        self.setupConstraints()
    }
    
    func setupTableView(){
        //Setup TableView
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = true
        tableView.sectionHeaderHeight = 64+44
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(FiltersCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.estimatedRowHeight = 100
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 92, 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        //Setup TableView Header
        let tableViewHeader = FiltersTableHeader(frame: .zero)
        tableViewHeader.frame.size.height = 80
        tableView.tableHeaderView = tableViewHeader
    }
    
    func setupFloatingButton(){
        applyFiltersButton = CNFloatingButton(frame: .zero)
        applyFiltersButton.setTitle("applyFilters".localized().uppercased(), for: .normal)
        applyFiltersButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(applyFiltersButton)
    }
    
    func setupConstraints(){
        let viewDict = ["tableView": tableView, "applyFiltersButton": applyFiltersButton] as [String : Any]
        //Width & Horizontal Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[applyFiltersButton]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        //Height & Vertical Alignment
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[applyFiltersButton(60)]-16-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict))
    }
    
    //UITableView DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return filters1.count
        case 1:
            return cuisineCategories.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = FiltersSectionHeader()
        sectionHeader.configure(title: "cuisines".localized().uppercased())
        
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:
            return 0
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FiltersCell
        
        switch indexPath.section{
        case 0:
            cell.configure(title: filters1[indexPath.row].localized())
            return cell
        case 1:
            cell.configure(title: cuisineCategories[indexPath.row].localized())
            return cell
        default:
            return cell
        }
    }
    
    //TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Show Feature Unavailable
        //TODO: Include ability to filter search
        self.present(featureUnavailableAlert(), animated: true, completion: nil)
    }
    
    //MARK: BarButtonItem Delegates
    func cancelButtonPressed(){
        self.dismiss(animated: true, completion: nil)
    }
}
