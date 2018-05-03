//
//  RestaurantManager.swift
//  ChowNow
//
//  Created by Justin Wells on 5/1/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RestaurantManager: NSObject{
    
    var ref: DatabaseReference!
    
    func downloadRestaurants(city: String, completionHandler:@escaping ([Restaurant]?) -> Void){
        var restaurants = [Restaurant]()
        ref = Database.database().reference().child(restaurantDatabase)
        let query: DatabaseQuery = ref.queryOrdered(byChild: "locality").queryEqual(toValue: city).queryLimited(toFirst: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(restaurants)
                return
            }
            
            for child in snapshot.children{
                //Create Restaurant
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! NSDictionary
                let restaurant = self.createRestaurant(rawData: rawData)
                restaurants.append(restaurant)
            }
            
            completionHandler(restaurants)
        })
    }
    
    func downloadRestaurants(category: String, completionHandler:@escaping ([Restaurant]?) -> Void){
        var restaurants = [Restaurant]()
        ref = Database.database().reference().child(restaurantCategoryDatabase).child(category)
        let query: DatabaseQuery = ref.queryLimited(toFirst: paginationLimit)
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                completionHandler(restaurants)
                return
            }
            
            for child in snapshot.children{
                //Create Restaurant
                let childSnapshot = child as? DataSnapshot
                let rawData = childSnapshot?.value as! NSDictionary
                let restaurant = self.createRestaurant(rawData: rawData)
                restaurants.append(restaurant)
            }
            completionHandler(restaurants)
        })
    }
    
    func createRestaurant(rawData: NSDictionary?) -> Restaurant{
        let restaurant = Restaurant()
        restaurant.objectId = rawData?.object(forKey: "objectId") as! String!
        restaurant.createdAt = rawData?.object(forKey: "createdAt") as! NSNumber!
        restaurant.updatedAt = rawData?.object(forKey: "updatedAt") as! NSNumber!
        restaurant.name = rawData?.object(forKey: "name") as! String!
        restaurant.image = rawData?.object(forKey: "image") as! String!
        restaurant.distance = rawData?.object(forKey: "distance") as! String!
        restaurant.categories = rawData?.object(forKey: "categories") as! String!
        restaurant.latitude = rawData?.object(forKey: "latitude") as! NSNumber!
        restaurant.longitude = rawData?.object(forKey: "longitude") as! NSNumber!
        restaurant.subThoroughfare = rawData?.object(forKey: "subThoroughfare") as! String!
        restaurant.thoroughfare = rawData?.object(forKey: "thoroughfare") as! String!
        restaurant.locality = rawData?.object(forKey: "locality") as! String!
        restaurant.administrativeArea = rawData?.object(forKey: "administrativeArea") as! String!
        restaurant.country = rawData?.object(forKey: "country") as! String!
        restaurant.postalCode = rawData?.object(forKey: "postalCode") as! String!
        restaurant.hasPickup = rawData?.object(forKey: "hasPickup") as! Bool!
        restaurant.hasDelivery = rawData?.object(forKey: "hasDelivery") as! Bool!
        restaurant.openTime = rawData?.object(forKey: "openTime") as! NSNumber!
        restaurant.closeTime = rawData?.object(forKey: "closeTime") as! NSNumber!

        return restaurant
    }
}
