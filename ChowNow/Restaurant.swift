//
//  Restaurant.swift
//  ChowNow
//
//  Created by Justin Wells on 4/28/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation

class Restaurant: NSObject{
    var objectId: String!
    var createdAt: NSNumber!
    var updatedAt: NSNumber!
    var name: String!
    var image: String!
    var categories: String!
    var distance: String!
    var latitude: NSNumber!
    var longitude: NSNumber!
    var subThoroughfare: String! //Street Number
    var thoroughfare: String! //Street
    var locality: String! //City
    var administrativeArea: String! //State
    var country: String! //Country
    var postalCode: String!//Zip Code
    var hasPickup: Bool!
    var hasDelivery: Bool!
    var openTime: NSNumber!
    var closeTime: NSNumber!
}
