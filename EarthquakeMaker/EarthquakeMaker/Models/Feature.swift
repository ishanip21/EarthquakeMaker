//
//  Feature.swift
//  EarthquakeMaker
//
//  Created by Ishan on 3/22/18.
//  Copyright © 2018 Ishan. All rights reserved.
//

import UIKit
import ObjectMapper

class Feature: Mappable {
    var type: String?
    var featureId: String?
    var propertie: Propertie?
    var geometry: Geometry?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        type        <- map["type"]
        featureId   <- map["id"]
        propertie   <- map["properties"]
        geometry    <- map["geometry"]
    }
}


