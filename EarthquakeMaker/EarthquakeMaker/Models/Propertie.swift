//
//  Properties.swift
//  EarthquakeMaker
//
//  Created by Ishan on 3/22/18.
//  Copyright © 2018 Ishan. All rights reserved.
//

import UIKit
import ObjectMapper

class Propertie: Mappable {
    var mag: Decimal?
    var place: String?
    var time: Int64?
    var timeZone: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        mag <- map["mag"]
        place <- map["place"]
        time <- map["time"]
        timeZone <- map["tz"]
    }
}

