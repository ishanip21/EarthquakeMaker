//
//  Geometry.swift
//  EarthquakeMaker
//
//  Created by Ishan on 3/22/18.
//  Copyright © 2018 Ishan. All rights reserved.
//

import UIKit
import ObjectMapper

class Geometry: Mappable {
    var type: String?
    var coordinates: [AnyObject]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        type        <- map["type"]
        coordinates <- map["coordinates"]
    }
    

}

