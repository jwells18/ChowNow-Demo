//
//  MapManager.swift
//  ChowNow
//
//  Created by Justin Wells on 5/2/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

import MapKit

class MapManager: NSObject{
    
    func createRestaurantMapAnotations(restaurants: [Restaurant], completionHandler:@escaping ([CNMapAnnotation]) -> Void){

        var mapAnnotations = [CNMapAnnotation]()
        for restaurant in restaurants{
            let annotation = CNMapAnnotation(restaurant: restaurant)
            mapAnnotations.append(annotation)
        }
        
        completionHandler(mapAnnotations)
    }
}
