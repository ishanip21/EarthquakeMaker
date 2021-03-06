//
//  Earthquake.swift
//  EarthquakeMaker
//
//  Created by Ishan on 3/22/18.
//  Copyright © 2018 Ishan. All rights reserved.
//

import UIKit
import ObjectMapper

class Earthquake: Mappable {
    var type: String?
    var features: [Feature]?
    var boundingBox:[Double]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        type        <- map["type"]
        features    <- map["features"]
        boundingBox <- map["bbox"]
    }
}
