//
//  Constants.swift
//  ChowNow
//
//  Created by Justin Wells on 4/28/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import CoreLocation

//View Dimensions
let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let w = screenSize.width
let h = screenSize.height

//UIObject Dimensions
let navigationHeight: CGFloat = 44.0
let statusBarHeight: CGFloat = 20.0
let navigationHeaderAndStatusbarHeight : CGFloat = navigationHeight + statusBarHeight
let tabBarHeight: CGFloat = 49.0
let searchBarFontSize = CGFloat(16)

//Custom Colors
struct CNColor{
    static let primary = UIColorFromRGB(0x00223C)
    static let secondary = UIColorFromRGB(0xFC4F56)
    static let tertiary = UIColorFromRGB(0x2ECECE)
    static let faintGray = UIColor(white: 0.9, alpha: 1)
    static let dimGray = UIColor(white: 0.95, alpha: 1)
}

public func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//Database
var restaurantDatabase = "Restaurant"
var restaurantCategoryDatabase = "RestaurantCategory"
var paginationLimit = UInt(15)
var paginationUpperLimit = 150

//Arrays
let cuisineCategories = ["pizza", "americanNew", "mexican", "italian", "americanTraditional", "sandwiches", "cafe", "burgers", "thai", "deli", "breakfastAndBrunch", "barbecue", "asianFusion", "japanese", "sushiBars", "mediterranean", "indian", "chinese", "seafood", "vegetarian"]
let cuisineCategoryImages = [UIImage(named:"pizza"), UIImage(named:"americanNew"), UIImage(named:"mexican"), UIImage(named:"italian"), UIImage(named:"americanTraditional"), UIImage(named:"sandwiches"), UIImage(named:"cafe"), UIImage(named:"burgers"), UIImage(named:"thai"), UIImage(named:"deli"), UIImage(named:"breakfastAndBrunch"), UIImage(named:"barbecue"), UIImage(named:"asianFusion"), UIImage(named:"japanese"), UIImage(named:"sushiBars"), UIImage(named:"mediterranean"), UIImage(named:"indian"), UIImage(named:"chinese"), UIImage(named:"seafood"), UIImage(named:"vegetarian")]
let filters1 = ["openNow", "deliversToMe"]
let settingsTitles = ["accountSettings", "payment", "savedAddresses", "logOut"]

//Feature Not Available
public func featureUnavailableAlert() -> UIAlertController{
    //Show Alert that this feature is not available
    let alert = UIAlertController(title: "sorry".localized(), message: "featureUnavailableMessage".localized(), preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "ok".localized(), style: .default, handler: nil))
    return alert
}

//Sample Data
let currentUser = createSampleUser()
var currentSearchParameter = UserDefaults.standard.value(forKey: "currentSearchParameter") as? String
let sampleLocation = CLLocation(latitude: 34.053718, longitude: -118.2448473)
let sampleLocationName = "Los Angeles"
let sampleLocationNameLong = "Los Angeles, CA"

//Other Functions
func determineGreetingString() -> String{
    let hour = Calendar.current.component(.hour, from: Date())
    
    switch hour{
    case _ where hour >= 0 && hour < 12:
        return "goodMorning".localized()
    case _ where  hour >= 12 && hour < 17:
        return "goodAfternoon".localized()
    case _ where hour >= 17:
        return "goodEvening".localized()
    default:
        return "greetings".localized()
    }
}

func determineRestaurantCategoryString(restaurant: Restaurant?) -> NSAttributedString{
    //Convert categories string to Array
    let categoryArray = (restaurant?.categories.components(separatedBy: ","))!
    //Localize Strings
    var categoryLocalizedArray = [String]()
    for string in categoryArray{
        categoryLocalizedArray.append(string.localized())
    }
    //Convert Array to stylized string
    //TODO: Add color attribute to separator
    let categoryString = categoryLocalizedArray.joined(separator: " / ").uppercased()

    return NSAttributedString(string: categoryString)
}

func determineRestaurantStatusString(restaurant: Restaurant?) -> String{
    //TODO: Add whether restaurant is open or closed to logic
    if((restaurant?.hasPickup)! && (restaurant?.hasDelivery)!){
        return String(format: "%@ & %@","pickup".localized().uppercased(), "delivery".localized().uppercased())
    }
    else if(restaurant?.hasPickup)!{
        return "pickup".localized().uppercased()
    }
    else if(restaurant?.hasDelivery)!{
        return "delivery".localized().uppercased()
    }
    else{
        return ""
    }
}


