//
//  SampleData.swift
//  ChowNow
//
//  Created by Justin Wells on 4/28/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

func createSampleUser() -> User{
    let user = User()
    user.objectId = "a1b2c3d4c5"
    user.name = "Sarah"
    
    return user
}

func createSampleRestaurant() -> Restaurant{
    let restaurant = Restaurant()
    restaurant.name = "Italian Gourmet Deli"
    restaurant.categories = "breakfastAndBrunch,deli"
    restaurant.hasPickup = true
    restaurant.hasDelivery = false
    
    return restaurant
}

func createSampleRestaurants() -> [Restaurant]{
    
    var restaurants = [Restaurant]()
    while restaurants.count < 16 {
        restaurants.append(createSampleRestaurant())
    }
    
    return restaurants
}

func uploadSampleRestaurants(){
    //Restaurant Data Array
    var restaurantDataArray = [Dictionary<String, Any>]()
    
    //Create Sample Restaurant Data
    let ref = Database.database().reference()
    for i in stride(from: 0, to: sampleRestaurantNames.count-1, by: 1) {
        var restaurantData = Dictionary<String, Any>()
        restaurantData["objectId"] = ref.childByAutoId().key
        restaurantData["createdAt"] = ServerValue.timestamp()
        restaurantData["updatedAt"] = ServerValue.timestamp()
        restaurantData["name"] = sampleRestaurantNames[i]
        restaurantData["categories"] = sampleRestaurantCategories[i]
        restaurantData["distance"] = sampleRestaurantDistance[i]
        restaurantData["latitude"] = sampleRestaurantLatitude[i]
        restaurantData["longitude"] = sampleRestaurantLongitude[i]
        restaurantData["locality"] = "Los Angeles" //City
        restaurantData["administrativeArea"] = "CA" //State
        restaurantData["country"] = "USA"
        restaurantData["hasPickup"] = sampleRestaurantHasPickup[i]
        restaurantData["hasDelivery"] = sampleRestaurantHasDelivery[i]
        //restaurantData["openTime"] =
        //restaurantData["closeTime"] =
        restaurantDataArray.append(restaurantData)
    }
    
    //Upload Restaurant to Restaurant Database
    for restaurantData in restaurantDataArray{
        ref.child(restaurantDatabase).child(restaurantData["objectId"] as! String).setValue(restaurantData) { (error:Error?, DatabaseReference) in
            if((error) != nil){
                print("Error uploading restaurant: \(error)")
            }
        }
    }
    
    //Upload Restaurant to Category Database
    for restaurantData in restaurantDataArray{
        let categories = restaurantData["categories"] as! String
        let categoryArray = (categories.components(separatedBy: ","))
        for category in categoryArray{
            ref.child(restaurantCategoryDatabase).child(category).child(restaurantData["objectId"] as! String).setValue(restaurantData) { (error:Error?, DatabaseReference) in
                if((error) != nil){
                    print("Error uploading restaurant for category: \(category), error: \(error)")
                }
            }
        }
    }
}

//Sample Resturant Raw Data
let sampleRestaurantNames = ["The Mighty Restaurant", "Mike's Deli", "Far Bar", "Takoyaki Tanota", "Orleans and York", "Cafe Dulce", "Wexler's Deli", "G&B Coffee", "Prawn Coastal Casual", "Prime Pizza", "Kazunori", "Ocho Mexican Grill", "La Luz del Dia", "Oleego", "Green Grotto Juice Bar", "Springtime in New York Cafe"]
let sampleRestaurantCategories = ["americanNew", "deli", "asianFusion", "asianFusion,japanese", "cajun,creole,cheesesteaks", "cafe", "deli,sandwiches", "cafe,teaHouse", "seafood", "pizza,sandwiches", "sushiBars", "mexican", "fastFood,mexican", "korean", "smoothieBar", "mediterranean"]
let sampleRestaurantDistance = ["0.1 miles", "0.2 miles", "0.3 miles", "0.3 miles", "0.3 miles", "0.3 miles", "0.3 miles", "0.3 miles", "0.3 miles", "0.4 miles", "0.4 miles", "0.4 miles", "0.5 miles", "0.6 miles", "0.6 miles", "0.6 miles"]
let sampleRestaurantLatitude = [34.0510171, 34.0506033, 34.0497531, 34.0493748, 34.0497414, 34.0488523, 34.0506594, 34.0510994, 34.0507774, 34.0481805, 34.0477489, 34.0533393, 34.0570184, 34.0570572, 34.0465114, 34.0461523]
let sampleRestaurantLongitude = [-118.2470163, -118.2437436, -118.2416535, -118.2419597, -118.250098, -118.2426483, -118.2509891, -118.251603, -118.251005, -118.2416519, -118.2501098, -118.2535144, -118.240737, -118.2561063, -118.252909, -118.2531848]
let sampleRestaurantHasPickup = [true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true]
let sampleRestaurantHasDelivery = [false, false, true, false, true, false, false, false, false, true, false, true, true, false, true, true]


