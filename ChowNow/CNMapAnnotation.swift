//
//  CNMapAnnotation.swift
//  ChowNow
//
//  Created by Justin Wells on 5/2/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import Foundation
import MapKit

class CNMapAnnotation: NSObject, MKAnnotation{
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var restaurant: Restaurant?
    
    init(restaurant: Restaurant) {
        self.title = restaurant.name
        self.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude.doubleValue, longitude: restaurant.longitude.doubleValue)
        self.restaurant = restaurant
        
        super.init()
    }
}
